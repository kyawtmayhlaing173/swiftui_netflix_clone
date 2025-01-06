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
    
    private var filteredCategory: MediaType? = nil
    private var filteredGenre: Genre? = nil
    
    private var isLoading = false
    private var currentPage = 1
    private var totalPages = 0
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers(){
        $allMovies
            .combineLatest(movieDataService.$movies)
            .sink { [weak self] (_, returnedMovie) in
                guard let self = self else { return }
                totalPages = returnedMovie?.total_pages ?? 1
                let movies = returnedMovie?.results ?? []
                
                if (currentPage == 1) {
                    self.allMovies = []
                    self.allMovies = movies
                } else {
                    self.allMovies.append(contentsOf: movies)
                }
                isLoading = false
                
                print("Appended Array is \(self.allMovies.count) \(currentPage) \(totalPages)")
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
    
    func getTrendingMovies(category: MediaType) {
        currentPage = 1
        filteredCategory = category
        filteredGenre = nil
        movieDataService.getTrendingMovies(category: category, index: 1)
    }
    
    func getTrendingMovies() {
        currentPage = 1
        filteredCategory = nil
        filteredGenre = nil
        movieDataService.getMovies(index: currentPage)
    }
    
    func getMovieByGenre(genre: Genre) {
        currentPage = 1
        filteredCategory = nil
        filteredGenre = genre
        movieDataService.getMovieByGenres(genreId: genre.id, index: currentPage)
    }
    
    func getMoreDataIfNeeded() {
        currentPage = currentPage + 1;
        print("⛔️ Current page is \(currentPage)")
        if isLoading { return }
        if (totalPages > currentPage) {
            isLoading = true
            if (filteredCategory == MediaType.movie || filteredCategory == MediaType.tv) {
                movieDataService.getTrendingMovies(category: filteredCategory!, index: currentPage)
            } else if (filteredGenre != nil){
                movieDataService.getMovieByGenres(genreId: filteredGenre!.id, index: currentPage)
            } else if (filteredCategory == nil) {
                movieDataService.getMovies(index: currentPage)
            }
        }
    }
}
