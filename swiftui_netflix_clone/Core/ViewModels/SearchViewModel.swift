//
//  SearchViewModel.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 03/12/2024.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var allMovies: [Movie] = []
//    let searchQuery: String
    
    private let searchDataService: SearchDataService
    private var cancellables = Set<AnyCancellable>()
    
    init() {
//        self.searchQuery = query
        searchDataService = SearchDataService()
        addSubscribers()
    }
    
    func addSubscribers() {
        $allMovies
            .combineLatest(searchDataService.$movies)
            .sink { [weak self] (_, returnedMovies) in
                guard let self = self else { return }
                self.allMovies = returnedMovies?.results ?? []
            }
            .store(in: &cancellables)
    }
    
    func getDiscoverMovie() {
        searchDataService.getDiscoverMovie()
    }
    
    func searchMovie(with query: String) {
        searchDataService.searchMovie(with: query)
    }    
}
