//
//  NetflixNewsViewModel.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 08/01/2025.
//

import Foundation
import Combine

class NetflixNewsViewModel: ObservableObject {
    @Published var allMovies: [Movie] = []
    @Published var moviesWithYoutube: [MovieWithYouTubeId] = []

    
    private let movieDataService = MovieNewsDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchMoviesWithYoutubeIds()
    }
    
    func fetchMoviesWithYoutubeIds() {
            $allMovies.combineLatest(movieDataService.$movies)
                .map { _, returnedMovies -> [Movie] in
                    let movies = (returnedMovies?.results ?? [])
                    return Array(movies.prefix(10))
                }
                .flatMap { movies -> AnyPublisher<[MovieWithYouTubeId], Never> in
                    let publishers = movies.map { movie in
                        self.movieDataService.fetchYoutubeId(for: "\(movie.original_title ?? movie.original_name ?? "")'s trailer")
                            .map { youtubeId in
                                MovieWithYouTubeId(movie: movie, youtubeId: youtubeId)
                            }
                    }
                    
                    return Publishers.MergeMany(publishers)
                        .collect()
                        .eraseToAnyPublisher()
                }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] moviesWithYoutube in
                    self?.moviesWithYoutube = moviesWithYoutube
                }
                .store(in: &cancellables)
        }

}
