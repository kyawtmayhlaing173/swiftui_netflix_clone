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
    @Published var episodes: [Episode] = []
    @Published var videoKeys: [Int:String] = [:]
    @Published var contentRating: String?
    
    let searchQuery: String
    private let movieDetailService: MovieDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(searchQuery: String, movieId: Int, mediaType: String, seasonNo: Int = 1) {
        self.searchQuery = searchQuery
        movieDetailService = MovieDetailDataService(
            searchQuery: "\(searchQuery) trailer",
            movieId: movieId,
            mediaType: mediaType
        )
        setupSubscriptions()
        if (mediaType == "tv") {
            getEpisodes(with: movieId, seasonNo: seasonNo)
        }
    }
    
    private func setupSubscriptions() {
        // Movie detail subscription
        movieDetailService.$movieDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movieDetail in
                self?.movie = movieDetail
            }
            .store(in: &cancellables)
        
        // YouTube link subscription
        movieDetailService.$movieDetailYoutubeLink
            .receive(on: DispatchQueue.main)
            .sink { [weak self] videoElement in
                self?.searchResult = videoElement
                self?.youtubeId = videoElement?.id.videoId
            }
            .store(in: &cancellables)
            
        // Movie credits subscription
        movieDetailService.$movieCasts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] casts in
                self?.movieCredit = casts
            }
            .store(in: &cancellables)
            
        // Recommendations subscription
        movieDetailService.$recommendations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] recommendations in
                self?.recommendations = recommendations
            }
            .store(in: &cancellables)
            
        // Episodes subscription
        movieDetailService.$episodes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] episodes in
                self?.episodes = episodes
            }
            .store(in: &cancellables)
        
        movieDetailService.$rating
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ratings in
                let usRating = ratings.first { rating in
                    rating.iso_3166_1 == "US"
                }
                self?.contentRating = self?.getDecodedRating(rating: (usRating?.rating ?? ""))
            }
            .store(in: &cancellables)
    }
    
    func getDecodedRating(rating: String) -> String {
        switch rating {
        case "TV-Y": return "All Ages"
        case "TV-Y7": return "7+"
        case "TV-G": return "All Ages"
        case "TV-PG": return "Parental Guidance"
        case "TV-14": return "14+"
        case "TV-MA": return "16+"
        default: return ""
        }
    }
    
    func getEpisodes(with movieId: Int, seasonNo: Int) {
        movieDetailService.getEpisodes(seasonNo: seasonNo, movieId: movieId)
    }
    
    private func fetchVideoKey(for episodes: [Episode]) {
        let group = DispatchGroup()
        
        for episode in episodes {
            guard let epNo = episode.episode_number else {
                print("⚠️ Skipping episode with missing episode_number")
                continue
            }
            
            group.enter()
            getEpisodeVideo(seasonNo: 1, episodeNo: epNo) {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("🎬 Completed fetching all episode video keys")
            print("Final videoKeys state: \(self.videoKeys)")
        }
    }
    
    private func getMovieCredit() {
    }
    
    private func getEpisodeVideo(seasonNo: Int, episodeNo: Int, completion: @escaping () -> Void = {}) {
        guard let movie = movie else {
            print("⚠️ Movie is nil")
            return
        }
                
        movieDetailService.getEpisodeVideo(movieId: movie.id, seasonNo: seasonNo, episodeNo: episodeNo) { [weak self] episodes in
            guard let self = self else { return }
            let videoKey = episodes.first?.key ?? ""
            
            DispatchQueue.main.async {
                self.videoKeys[episodeNo] = videoKey
                print("🎥 Updated video key for episode \(episodeNo): \(videoKey)")
                self.objectWillChange.send()  // Explicitly notify of change
                completion()
            }
        }
    }
}
