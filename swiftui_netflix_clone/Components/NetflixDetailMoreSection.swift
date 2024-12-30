//
//  NetflixDetailMoreSection.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 13/12/2024.
//

import SwiftUI

enum MovieDetailTab: CaseIterable {
    case more, trailers, episodes
}

struct NetflixDetailMoreSection: View {
    @State private var selectedTab = MovieDetailTab.more
    @ObservedObject var detailVM: NetflixDetailsViewModel
    var mediaType: String
    @Environment(\.router) var router
    @State private var shouldPlay = false

    let layout = [
        GridItem(.flexible(maximum: 500), spacing: 16),
        GridItem(.flexible(maximum: 500), spacing: 16),
        GridItem(.flexible(maximum: 500), spacing: 16),
    ]
    
    private func onMoviePressed(movie: Movie) {
        router.showScreen(.sheet) { _ in
            NetflixDetailsView(movie: movie)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 16) {
                    if(mediaType == "tv") {
                        CustomTabBar(
                            isSelected: selectedTab == MovieDetailTab.episodes,
                            title: "Episodes") {
                                selectedTab = MovieDetailTab.episodes
                            }
                    }
                    CustomTabBar(
                        isSelected: selectedTab == MovieDetailTab.more,
                        title: "More Like This") {
                            selectedTab = MovieDetailTab.more
                        }
                    if(mediaType == "movie") {
                        CustomTabBar(
                            isSelected: selectedTab == MovieDetailTab.trailers,
                            title: "Trailers & More") {
                                selectedTab = MovieDetailTab.trailers
                            }
                    }
                }
                .padding(.bottom)
                if (selectedTab == MovieDetailTab.more) {
                    LazyVGrid(columns: layout, spacing: 16) {
                        ForEach(detailVM.recommendations, id: \.self) { movie in
                            NetflixMovieCell(
                                width: .infinity,
                                imageName: movie.poster_path,
                                title: movie.original_name ?? movie.original_title ?? "",
                                isRecentlyAdded: false
                            )
                            .onTapGesture {
                                onMoviePressed(movie: movie)
                            }
                        }
                    }
                }
                else if (selectedTab == MovieDetailTab.trailers) {
                    NetflixTrailerView(videoId: detailVM.youtubeId ?? "", shouldPlay: $shouldPlay)
                        .frame(height: 200)
                }
                else if (selectedTab == MovieDetailTab.episodes) {
                    NetflixEpisodesView(detailVM: detailVM)
                }
            }
            .padding(.horizontal)
            .foregroundStyle(Color.netflixWhite)
        }
        .onAppear {
            selectedTab = mediaType == "tv" ? MovieDetailTab.episodes : MovieDetailTab.more
        }
    }
}

struct CustomTabBar: View {
    var isSelected: Bool
    var title: String
    var onTabPressed: (() -> Void)?
    
    @State private var textWidth: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
           Rectangle()
               .frame(width: textWidth, height: 6)
               .foregroundStyle(isSelected ? .netflixDarkRed : .clear)

           Text(title)
               .fontWeight(isSelected ? .bold : .regular)
               .background(
                   GeometryReader { geometry in
                       Color.clear
                           .onAppear {
                               textWidth = geometry.size.width
                           }
                   }
               )
       }
       .foregroundStyle(Color.netflixWhite)
       .onTapGesture {
           onTabPressed?()
       }
    }
}

#Preview {
    // For Movie
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixDetailMoreSection(
            detailVM: DeveloperPreview().detailsVMForMovie,
            mediaType: MediaType.movie.title
        )
    }
}

#Preview {
    // For Tv Show
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixDetailMoreSection(
            detailVM: DeveloperPreview().detailsVMForTvShow,
            mediaType: MediaType.tv.title
        )
    }
}
