//
//  MovieDetailDataService.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 01/12/2024.
//

import Foundation
import Combine

class MovieDetailDataService {
    let searchQuery: String
    @Published var movieDetailYoutubeLink: VideoElement?
    @Published var movieCasts: [Cast] = []
    @Published var recommendations: [Movie] = []
    var movieDetailSubscription: AnyCancellable?
    var creditSubscription: AnyCancellable?
    var recommendationSubscription: AnyCancellable?
    let movieId: Int
    
    init(searchQuery: String, movieId: Int) {
        self.searchQuery = searchQuery
        self.movieId = movieId
        getMovieDetailVideo(with: searchQuery)
        getMovieCredit(with: movieId)
        getRecommendationMovie(with: movieId)
    }
    
    func getMovieDetailVideo(with query: String) {
        if (query.isEmpty) { return }
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
        movieDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: YoutubeSearchResults.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] results in
                    self?.movieDetailYoutubeLink = results.items[0]
                    self?.movieDetailSubscription?.cancel()
            })
    }
    
    func getMovieCredit(with movieId: Int) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/\(movieId)/credits?api_key=\(Constants.API_KEY)") else { return }
        creditSubscription = NetworkingManager.download(url: url)
            .decode(type: Credits.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] results in
                self?.movieCasts = results.cast
                self?.creditSubscription?.cancel()
            })
                
    }
    
    func getRecommendationMovie(with movieId: Int) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/\(movieId)/recommendations?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        recommendationSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] results in
                    self?.recommendations = results.results
                self?.recommendationSubscription?.cancel()
            })
    }
}
