//
//  MovieNewsDataService.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 08/01/2025.
//

import Foundation
import Combine
import Alamofire

class MovieNewsDataService {
    @Published var trendingMovies: MovieResponse?
    @Published var topTenMovies: MovieResponse?
    @Published var topTenTvShows: MovieResponse?

    var trendingSubscription: AnyCancellable?
    var topTenMovieSubscription: AnyCancellable?
    var topTenTvSubscription: AnyCancellable?
    
    init() {
        getTopTenMovies()
        getTrendingMovies()
        getTopTenTvShows()
    }
    
    func getTrendingMovies() {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {
            return
        }
        trendingSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] movies in
                self?.trendingMovies = movies
                print("🔥Result 1 is \(movies.results.count)")
                self?.trendingSubscription?.cancel()
            })
    }
    
    func getTopTenMovies() {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {
            return
        }
        topTenMovieSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] movies in
                self?.topTenMovies = movies
                self?.topTenMovieSubscription?.cancel()
            })
    }
    
    func getTopTenTvShows() {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {
            return
        }
        topTenTvSubscription = NetworkingManager.download(url: url)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] movies in
                self?.topTenTvShows = movies
                self?.topTenTvSubscription?.cancel()
            })
    }
    
    func fetchYoutubeId(for query: String) -> AnyPublisher<String, Never> {
        Future { promise in
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                  let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {
                promise(.success(""))
                return
            }
            
            AF.request(url)
                .validate()
                .responseDecodable(of: YoutubeSearchResults.self) { response in
                    switch response.result {
                    case .success(let results):
                        let videoId = results.items.first?.id.videoId ?? ""
                        promise(.success(videoId))
                    case .failure(let error):
                        promise(.success(""))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
