//
//  Genres.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 09/12/2024.
//

import Foundation

struct GenresResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Hashable {
    let id: Int
    let name: String
}
