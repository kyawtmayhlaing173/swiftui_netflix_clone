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
    @Published var genres: GenresResponse = GenresResponse(genres: [])
    var movieSubscription: AnyCancellable?
    var genreSubscription: AnyCancellable?
    
    init() {
        getMovies()
        getGenres()
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
    
    func getTrendingMovies(category: MediaType) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/\(category.title)/day?api_key=\(Constants.API_KEY)") else { return }
        movieSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:), receiveValue: { [weak self] movies in
                self?.movies = movies
                self?.movieSubscription?.cancel()
            })
    }
    
    func getGenres() {
        guard let url = URL(string: "\(Constants.baseURL)/3/genre/movie/list?api_key=\(Constants.API_KEY)") else {
            return
        }
        genreSubscription = NetworkingManager.download(url: url)
            .decode(type: GenresResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] genres in
                self?.genres = genres
                self?.genreSubscription?.cancel()
            })
    }
    
    func getMovieByGenres(genreId: Int) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=\(genreId)") else { return }
        movieSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] movies in
                self?.movies = movies
                self?.movieSubscription?.cancel()
            })
        
    }
}
