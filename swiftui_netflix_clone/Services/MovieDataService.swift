//
//  MovieDataService.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 27/11/2024.
//

import Foundation
import Combine

class MovieDataService {
    @Published var movies: MovieResponse = MovieResponse(results: [])
    var movieSubscription: AnyCancellable?
    
    init() {
        getMovies()
    }
    
    func getMovies() {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {
            return
        }
        movieSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] movies in
                self?.movies = movies
                self?.movieSubscription?.cancel()
            })
    }
}
