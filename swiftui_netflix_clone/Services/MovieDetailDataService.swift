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
    @Published var movieDetail: MovieDetailResponse?
    @Published var movieDetailYoutubeLink: VideoElement?
    @Published var movieCasts: [Cast] = []
    @Published var recommendations: [Movie] = []
    @Published var episodes: [Episode] = []
    @Published var episodeVideos: EpisodeVideo?
    @Published var rating: [Rating] = []
    
    var movieDetailSubscription: AnyCancellable?
    var movieTrailerSubscription: AnyCancellable?
    var creditSubscription: AnyCancellable?
    var recommendationSubscription: AnyCancellable?
    var episodeSubscription: AnyCancellable?
    var episodeVideosSubscription: AnyCancellable?
    var ratingSubscription: AnyCancellable?
    let movieId: Int
    let mediaType: String
    
    init(searchQuery: String, movieId: Int, mediaType: String) {
        self.searchQuery = searchQuery
        self.movieId = movieId
        self.mediaType = mediaType
        getMovieDetail(with: movieId, mediaType: mediaType)
        getMovieTrailer(with: searchQuery)
        getMovieCredit(with: movieId, mediaType: mediaType)
        getRecommendationMovie(with: movieId, mediaType: mediaType)
        getEpisodes(seasonNo: 1, movieId: movieId)
        getContentRating()
    }
    
    func getMovieDetail(with movieId: Int, mediaType: String) {
        guard let url = URL(string: "\(Constants.baseURL)/3/\(mediaType)/\(movieId)?language=en-US&api_key=\(Constants.API_KEY)") else { return }
        movieDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieDetailResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { movie in
                self.movieDetail = movie
                self.movieDetailSubscription?.cancel()
            })
    }
    
    func getMovieTrailer(with query: String) {
        if (query.isEmpty) { return }
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
        movieTrailerSubscription = NetworkingManager.download(url: url)
            .decode(type: YoutubeSearchResults.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] results in
                    self?.movieDetailYoutubeLink = results.items[0]
                    self?.movieTrailerSubscription?.cancel()
            })
    }
    
    func getMovieCredit(with movieId: Int, mediaType: String) {
        guard let url = URL(string: "\(Constants.baseURL)/3/\(mediaType)/\(movieId)/credits?api_key=\(Constants.API_KEY)") else { return }
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
    
    func getRecommendationMovie(with movieId: Int, mediaType: String) {
        guard let url = URL(string: "\(Constants.baseURL)/3/\(mediaType)/\(movieId)/recommendations?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
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
    
    func getEpisodes(seasonNo: Int, movieId: Int) {
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/\(movieId)/season/\(seasonNo)?api_key=\(Constants.API_KEY)") else { return }
        episodeSubscription = NetworkingManager.download(url: url)
            .decode(type: SeasonResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] results in
                self?.episodes = results.episodes;
            })
    }
    
    func getContentRating() {
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/222766/content_ratings?api_key=\(Constants.API_KEY)") else { return }
        ratingSubscription = NetworkingManager.download(url: url)
            .decode(type: ContentRatingResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] results in
                self?.rating = results.results
            })
    }
    
    func getEpisodeVideo(
        movieId: Int,
        seasonNo: Int,
        episodeNo: Int,
        completion: @escaping ([EpisodeVideo]) -> Void
    ) {
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/\(movieId)/season/\(seasonNo)/episode/\(episodeNo)/videos?api_key=\(Constants.API_KEY)") else {
            completion([])
            return
        }

        episodeVideosSubscription = NetworkingManager.download(url: url)
            .decode(type: EpisodeVideoResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { episodes in
                print("⛔️ \(episodes.results) \(url)")
                completion(episodes.results)
            })
    }
}
