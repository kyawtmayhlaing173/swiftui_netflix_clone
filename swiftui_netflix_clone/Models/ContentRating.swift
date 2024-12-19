//
//  ContentRating.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 18/12/2024.
//

import Foundation

struct ContentRatingResponse: Codable {
    let results: [Rating]
}

struct Rating: Codable {
    let descriptors: [String]?
    let iso_3166_1: String
    let rating: String
}
