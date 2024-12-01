//
//  NetflixDetailsViewModel.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 01/12/2024.
//

import Foundation
import Combine

class NetflixDetailsViewModel: ObservableObject {
    @Published var searchResult: VideoElement?
    @Published var youtubeId: String?
    let searchQuery: String
    
    private let movieDetailService: MovieDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(searchQuery: String) {
        self.searchQuery = searchQuery
        movieDetailService = MovieDetailDataService(searchQuery: "\(searchQuery) trailer")
        getMovie()
    }
    
    func getMovie() {
        movieDetailService.$movieDetailYoutubeLink
            .combineLatest($searchResult)
            .sink { [weak self] (videoElement, _) in
                self?.searchResult = videoElement
                guard let id = videoElement?.id.videoId else { return }
                self?.youtubeId = id
            }
            .store(in: &cancellables)
    }
}


