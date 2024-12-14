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
    @Published var genres: [Genre] = []
    
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
        
        $genres.combineLatest(movieDataService.$genres)
            .sink { [weak self] (_, returnedGenres) in
                guard let self = self else { return }
                self.genres = returnedGenres.genres
                savesGenresToUserDefaults(genres: genres)
            }
            .store(in: &cancellables)
    }
    
    func savesGenresToUserDefaults(genres: [Genre]) {
        if let encoded = try? JSONEncoder().encode(genres) {
            UserDefaults.standard.set(encoded, forKey: "Genres")
        }
    }
    
    func getGenresNameById(id: Int) -> String {
        var genres: [Genre] = []
        if let data = UserDefaults.standard.data(forKey: "Genres") {
            if let decoded = try? JSONDecoder().decode([Genre].self, from: data) {
                genres = decoded
            }
        }
        let selectedGenre = genres.first(where: { genre in
            genre.id == id
        })
        return selectedGenre?.name ?? ""
    }
    
    func getTrendingMovies(category: Trending){
        movieDataService.getTrendingMovies(category: category)
    }
    
    func getUpcomingMovies() {
        movieDataService.getMovies()
    }
    
    func getMovieByGenre(genreId: Int) {
        movieDataService.getMovieByGenres(genreId: genreId)
    }
}
