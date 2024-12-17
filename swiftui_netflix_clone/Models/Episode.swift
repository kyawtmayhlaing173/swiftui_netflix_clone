//
//  Episode.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 16/12/2024.
//

import Foundation

struct SeasonResponse: Codable, Hashable {
    let _id: String
    let air_date: String
    let episodes: [Episode]
}

struct Episode: Codable, Hashable, Identifiable {
    let air_date: String?
    let episode_number: Int?
    let episode_type: String?
    let id: Int
    let name: String?
    let overview: String?
    let production_code: String?
    let runtime: Int?
    let season_number: Int?
    let show_id: Int?
    let still_path: String?
    let vote_average: Double?
    let vote_count: Int?
}
