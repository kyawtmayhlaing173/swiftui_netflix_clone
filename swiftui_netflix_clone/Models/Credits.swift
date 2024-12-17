//
//  Credits.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 04/12/2024.
//

import Foundation

struct Credits: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable, Hashable {
    let adult: Bool
    let gender: Int
    let id: Int
    let known_for_department: String?
    let name: String?
    let original_name: String?
    let popularity: Double?
    let profile_path: String?
    let cast_id: Int?
    let character: String?
    let credit_id: String?
    let order: Int
}
