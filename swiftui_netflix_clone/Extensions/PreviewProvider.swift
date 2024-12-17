//
//  PreviewProvider.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 28/11/2024.
//

import Foundation
import SwiftUI

class DeveloperPreview {
    let homeVM = NetflixHomeViewModel()
    
    let movie = Movie(
        id: 645757,
        title: "That Christmas",
        media_type: "movie",
        original_name: "That Christmas",
        original_title: "That Christmas",
        poster_path: "/bX6dx2U4hOk1esI7mYwtD3cEKdC.jpg",
        overview: "It's an unforgettable Christmas for the townsfolk of Wellington-on-Sea when the worst snowstorm in history alters everyone's plans — including Santa's.",
        vote_count: 2,
        release_date: "2024-11-27",
        first_air_date: nil,
        vote_average: 8,
        genre_ids: [16, 35, 10751, 14]
    )
    
    let tvShow = Movie(
        id: 222766,
        title: "The Day of the Jackal",
        media_type: "tv",
        original_name: "The Day of the Jackal",
        original_title: "The Day of the Jackal",
        poster_path: "/wx1NFvapK10CvEppm9y8333uZWG.jpg",
        overview: "An unrivalled and highly elusive lone assassin, the Jackal, makes his living carrying out hits for the highest fee. But following his latest kill, he meets his match in a tenacious British intelligence officer who starts to track down the Jackal in a thrilling cat-and-mouse chase across Europe, leaving destruction in its wake.",
        vote_count: 176,
        release_date: nil,
        first_air_date: "2024-11-07",
        vote_average: 8.307,
        genre_ids: [18, 10759, 9648]
    )
    
    let detailsVMForMovie = NetflixDetailsViewModel(
        searchQuery: "That Christmas",
        movieId: 645757,
        mediaType: MediaType.movie.title
    )
    
    let detailsVMForTvShow = NetflixDetailsViewModel(
        searchQuery: "The Day of the Jackal",
        movieId: 222766,
        mediaType: MediaType.tv.title
    )

}
