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
    @Published var movie: MovieDetailResponse?
    @Published var recommendations: [Movie] = []
    let searchQuery: String
    
    
    private let movieDetailService: MovieDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(searchQuery: String, movieId: Int, mediaType: String) {
        self.searchQuery = searchQuery
        movieDetailService = MovieDetailDataService(
            searchQuery: "\(searchQuery) trailer",
            movieId: movieId,
            mediaType: mediaType
        )
        getMovie()
        getCredits()
        getRecommendations(with: movieId)
    }
    
    func getMovie() {
        movieDetailService.$movieDetail
            .combineLatest($movie)
            .sink { [weak self] (movie, _) in
                self?.movie = movie
            }
            .store(in: &cancellables)
        
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
            }
            .store(in: &cancellables)
    }
    
    func getRecommendations(with movieId: Int) {
        movieDetailService.$recommendations
            .combineLatest($recommendations)
            .sink { [weak self] (recommendations, _) in
                self?.recommendations = recommendations
            }
            .store(in: &cancellables)
    }
}


