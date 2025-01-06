//
//  NetflixTabBarView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 08/12/2024.
//

import SwiftUI

struct NetflixTabBarView: View {
    @StateObject private var homeVM = NetflixHomeViewModel()

    var body: some View {
        TabView {
            Group {
                NetflixHomeView()
                    .environmentObject(homeVM)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                NetflixNewsSectionView()
                    .tabItem {
                        Label("News & Hot", systemImage: "play.rectangle.on.rectangle")
                    }
                Text("My Netflix")
                    .tabItem {
                        Label("My Netflix", systemImage: "person")
                    }
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.netflixBlack.opacity(0.8), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    NetflixTabBarView()
}
