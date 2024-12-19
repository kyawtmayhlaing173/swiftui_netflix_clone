//
//  EpisodeVideo.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 17/12/2024.
//

import Foundation

struct EpisodeVideoResponse: Codable {
    let id: Int
    let results: [EpisodeVideo]
}

struct EpisodeVideo: Codable {
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let published_at: String
    let id: String
}
