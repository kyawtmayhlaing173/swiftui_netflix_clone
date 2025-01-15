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
    @Published var movies: MovieResponse?
    var movieSubscription: AnyCancellable?
    var movieTrailerSubscription: AnyCancellable?
    
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
                        case .failure:
                            promise(.success(""))
                        }
                    }
            }
            .eraseToAnyPublisher()
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
                receiveValue: { results in
                    let videoId = results.items.first?.id.videoId
            })
    }
}
