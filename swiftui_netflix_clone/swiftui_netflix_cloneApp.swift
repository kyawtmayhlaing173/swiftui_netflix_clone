//
//  swiftui_netflix_cloneApp.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 20/11/2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct swiftui_netflix_cloneApp: App {
    @StateObject private var homeVM = NetflixHomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                NetflixTabBarView()
            }
        }
    }
}
