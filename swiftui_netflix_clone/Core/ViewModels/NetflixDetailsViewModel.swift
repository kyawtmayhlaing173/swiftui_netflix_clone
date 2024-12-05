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
    @Published var movieCredit: [Cast] = []
    @Published var movie: Movie
    let searchQuery: String
    
    
    private let movieDetailService: MovieDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(searchQuery: String, movie: Movie) {
        self.searchQuery = searchQuery
        self.movie = movie
        movieDetailService = MovieDetailDataService(
            searchQuery: "\(searchQuery) trailer",
            movieId: movie.id
        )
        getMovie()
        getCredits()
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
    
    func getCredits() {
        movieDetailService.$movieCasts
            .combineLatest($movieCredit)
            .sink { [weak self] (casts, _) in
                self?.movieCredit = casts
                print("Movie credit \(self?.movieCredit)")
            }
            .store(in: &cancellables)
        
    }
}


