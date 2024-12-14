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
        vote_average: 8,
        genre_ids: [16, 35, 10751, 14]
    )
    
    let detailsVM = NetflixDetailsViewModel(
        searchQuery: "That Christmas",
        movie: Movie(
            id: 645757,
            title: "That Christmas",
            media_type: "movie",
            original_name: "That Christmas",
            original_title: "That Christmas",
            poster_path: "/bX6dx2U4hOk1esI7mYwtD3cEKdC.jpg",
            overview: "It's an unforgettable Christmas for the townsfolk of Wellington-on-Sea when the worst snowstorm in history alters everyone's plans — including Santa's.",
            vote_count: 2,
            release_date: "2024-11-27",
            vote_average: 8,
            genre_ids: [16, 35, 10751, 14]
        )
    )

}
