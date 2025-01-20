//
//  NetflixHomeView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 20/11/2024.
//

import SwiftUI
import SwiftfulRouting

enum MediaType {
    case tv, movie
    
    var title: String {
        switch self {
        case .tv: return "tv"
        case .movie: return "movie"
        }
    }
}

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var selectedCategory: String? = nil
    @State private var scrollViewOffset: CGFloat = 0
    @Environment(\.router) var router
    @EnvironmentObject var homeVM: NetflixHomeViewModel

    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            backgroundGradientLayer
            scrollViewLayer
            fullHeaderwithFilter
        }
    }
    
    private var backgroundGradientLayer: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .netflixDarkGray.opacity(1),
                    .netflixDarkGray.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            LinearGradient(
                colors: [
                    .netflixDarkRed.opacity(0.5),
                    .netflixDarkRed.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .frame(maxHeight: max(0, min(350, 350 - (scrollViewOffset * 1))))
        .opacity(scrollViewOffset > 200 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    private var scrollViewLayer: some View {
        let movies = homeVM.allMovies;
        
        return ScrollView(.vertical) {
            LazyVStack(spacing: 8) {
                Rectangle()
                    .opacity(0)
                    .frame(height: 120)
                if (movies.count > 0) {
                    
                    NetflixHeroCell(
                        imageName: movies[0].poster_path,
                        title: movies[0].title ?? movies[0].original_name ?? "",
                        categories: movies[0].genre_ids ?? [],
                        onBackgroundPressed: {
                            onMoviePressed(movie: movies[0])
                        },
                        onPlayPressed: {
                            onMoviePressed(movie: movies[0])
                        },
                        homeVM: homeVM
                    )
                        .padding(.horizontal, 32)
                }
                categoryRows
            }
        }
        .scrollIndicators(.hidden)
        .onScrollGeometryChange(for: Double.self) { geo in
            geo.contentOffset.y
        } action: { oldValue, newValue in
            scrollViewOffset = newValue
        }
    }
    
    private func onMoviePressed(movie: Movie) {
        router.showScreen(.sheet) { _ in
            NetflixDetailsView(movie: movie)
        }
    }
    
    private func onCategoriesPressed(genre: Genre) {
        homeVM.getMovieByGenre(genre: genre)
    }
    
    func getTrendingMoviesByCategory(selectedFilter: FilterModel?) {
        guard let filter = selectedFilter else { return }
        homeVM.getTrendingMovies(
            category: filter.title.lowercased().contains("tv") ? MediaType.tv: MediaType.movie
        )
    }
    
    private var fullHeaderwithFilter: some View {
        VStack(spacing: 0) {
            NetflixHeaderView(title: "For Pinky")
                .padding(.horizontal, 16)
            
            if scrollViewOffset < 0 {
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter,
                    selectedCategory: selectedCategory
                ) {
                        clearGenreData()
                } onFilterPressed: { newFilter in
                    selectedFilter = newFilter
                    if (newFilter.title != "Categories") {
                        getTrendingMoviesByCategory(selectedFilter: selectedFilter)
                    } else {
                        router.showScreen(
                            .fullScreenCover,
                            destination: { _ in
                                NetflixGenresList(
                                    genres: homeVM.genres,
                                    onGenrePressed: { genre in
                                        onCategoriesPressed(genre: genre)
                                        selectedCategory = genre.name
                                    },
                                    onXMarkPressed: {
                                        clearGenreData()
                                    }
                                )
                            .background(.ultraThinMaterial)
                        })
                    }
                }
                    .padding(.top, 16)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            ZStack {
                if scrollViewOffset > 20 {
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
    }
    
    func clearGenreData() {
        selectedFilter = nil
        selectedCategory = nil
        homeVM.getTrendingMovies()
    }
    
    private var categoryRows: some View {
        let categories = ["My List", "Today's Top Pick for You", "TV Action & Adventure"];
        
        return LazyVStack(spacing: 16) {
            ForEach(Array(categories.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row)
                        .font(.headline)
                        .padding(.horizontal, 1)

                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 16) {
                            let displayedMovies = rowIndex == 1 ? Array(homeVM.allMovies.prefix(20)) : homeVM.allMovies
                            ForEach(Array(displayedMovies.enumerated()), id: \.offset) {(index, product) in
                                NetflixMovieCell(
                                    imageName: product.poster_path,
                                    title: product.title,
                                    isRecentlyAdded: false,
                                    topTenRanking: rowIndex == 1 ? (index + 1) : nil
                                )
                                .onTapGesture {
                                    onMoviePressed(movie: product)
                                }
                                if (product == homeVM.allMovies.last) {
                                    Color.clear
                                        .onAppear {
                                            homeVM.getMoreDataIfNeeded()
                                        }
                                }
                            }
                            
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .padding(.horizontal, 12)
            .foregroundStyle(.netflixWhite)
        }
    }
}

extension NetflixHomeView {
    var progressView: some View {
        ProgressView()
            .tint(Color.netflixLightGray)
    }
}

#Preview {
    RouterView { _ in
        NetflixHomeView()
            .environmentObject(DeveloperPreview().homeVM)
    }
}

