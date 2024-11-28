//
//  NetflixHomeViewModel.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 27/11/2024.
//

import Foundation
import Combine

class NetflixHomeViewModel: ObservableObject {
    @Published var allMovies: [Movie] = []
    
    private let movieDataService = MovieDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers(){
        $allMovies
            .combineLatest(movieDataService.$movies)
            .sink { [weak self] (_, returnedMovie) in
                guard let self = self else { return }
                self.allMovies = returnedMovie.results
            }
            .store(in: &cancellables)
    }
}
