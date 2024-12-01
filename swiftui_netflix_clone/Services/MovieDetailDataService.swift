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
    var movieDetailSubscription: AnyCancellable?
    
    init(searchQuery: String) {
        self.searchQuery = searchQuery
        getMovieDetailVideo(with: searchQuery)
    }
    
    func getMovieDetailVideo(with query: String) {
        if (query.isEmpty) { return }
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
        movieDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: YoutubeSearchResults.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] results in                self?.movieDetailYoutubeLink = results.items[0]
            })
    }
}
