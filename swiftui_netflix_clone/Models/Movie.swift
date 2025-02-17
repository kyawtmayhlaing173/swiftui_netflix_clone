//
//  Movie.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 27/11/2024.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
    let page: Int
    let total_pages: Int
    let total_results: Int
}

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String?
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int?
    let release_date: String?
    let first_air_date: String?
    let vote_average: Double?
    let genre_ids: [Int]?
}

struct MovieWithYouTubeId: Codable, Hashable {
    let movie: Movie
    let youtubeId: String
}
