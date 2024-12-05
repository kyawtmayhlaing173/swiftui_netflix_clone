//
//  SearchDataService.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 03/12/2024.
//

import Foundation
import Combine

class SearchDataService {
    var searchMovieSubscription: AnyCancellable?
    @Published var movies: MovieResponse?
    
    init() {
        getDiscoverMovie()
    }
    
    func getDiscoverMovie() {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        searchMovieSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] results in
                self?.movies = results
                self?.searchMovieSubscription?.cancel()
            })
    }
    
    func searchMovie(with query: String) {
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }
        searchMovieSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] results in
                self?.movies = results
            })
    }
}
