//
//  MovieDetail.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 15/12/2024.
//

import Foundation

struct MovieDetailResponse: Codable, Hashable {
    let adult: Bool?
    let backdrop_path: String?
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdb_id: String?
    let number_of_seasons: Int?
    let number_of_episodes: Int?
    let origin_country: [String]?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let first_air_date: String?
    let runtime: Int?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
