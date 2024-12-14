//
//  NetflixDetailMoreSection.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 13/12/2024.
//

import SwiftUI

enum MovieDetailTab: CaseIterable {
    case more, trailers
    
    var title: String {
        switch self {
        case .more: return "More Like This"
        case .trailers: return "Trailers & More"
        }
    }
}

struct NetflixDetailMoreSection: View {
    @State private var selectedTab = MovieDetailTab.more
    @ObservedObject var detailVM: NetflixDetailsViewModel
    @Environment(\.router) var router

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
                    ForEach(MovieDetailTab.allCases, id: \.self) { tab in
                        CustomTabBar(
                            isSelected: selectedTab == tab,
                            title: tab.title
                        )
                        .onTapGesture {
                            selectedTab = tab
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
                    NetflixTrailerView(videoId: detailVM.youtubeId ?? "")
                        .frame(height: 200)
                }
            }
            .padding()
            .foregroundStyle(Color.netflixWhite)
        }
    }
}

struct CustomTabBar: View {
    var isSelected: Bool
    var title: String
    
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
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixDetailMoreSection(
            detailVM: DeveloperPreview().detailsVM
        )
    }
    
}
