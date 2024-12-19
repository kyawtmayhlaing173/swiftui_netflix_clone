//
//  NetflixEpisodesViewModel.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 17/12/2024.
//

import Foundation

class NetflixEpisodesViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    @Published var videoKeys: [Int:String] = [:]
    var movieId: Int
    var seasonNo: Int
    private let movieDetailService: MovieDetailDataService
    
    init(episodes: [Episode], videoKeys: [Int : String], movieId: Int, seasonNo: Int) {
        self.episodes = episodes
        self.videoKeys = videoKeys
        self.movieId = movieId
        self.seasonNo = seasonNo
        self.movieDetailService = MovieDetailDataService(
            searchQuery: "",
            movieId: movieId,
            mediaType: MediaType.tv.title
        )
    }
    
    
    
}
