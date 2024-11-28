//
//  NetflixHomeView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 20/11/2024.
//

import SwiftUI
import SwiftfulRouting

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
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
            VStack(spacing: 8) {
                Rectangle()
                    .opacity(0)
                    .frame(height: 120)
                if (movies.count > 0) {
                    NetflixHeroCell(
                        imageName: movies[0].poster_path,
                        title: movies[0].original_title ?? "",
                        onBackgroundPressed: {
                        onMoviePressed()
                    })
                        .padding(.horizontal, 32)
                }
                categoryRows
            }
        }
        .onScrollGeometryChange(for: Double.self) { geo in
            geo.contentOffset.y
        } action: { oldValue, newValue in
            scrollViewOffset = newValue
        }
    }
    
    private func onMoviePressed() {
        router.showScreen(.sheet) { _ in
            NetflixDetailsView()
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
            HStack(spacing: 14) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.down")
                    .onTapGesture {
                        
                    }
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
        }
        .background(Color.clear)
        .foregroundColor(Color.netflixWhite)
    }
    
    private var fullHeaderwithFilter: some View {
        VStack(spacing: 0) {
            header
                .padding(.horizontal, 16)
            
            if scrollViewOffset < 0 {
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter) {
                        selectedFilter = nil
                    } onFilterPressed: { newFilter in
                        selectedFilter = newFilter
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
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
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
                            ForEach(Array(homeVM.allMovies.enumerated()), id: \.offset) {(index, product) in
                                NetflixMovieCell(
                                    imageName: product.poster_path,
                                    title: product.original_title ?? "",
                                    isRecentlyAdded: false,
                                    topTenRanking: rowIndex == 1 ? (index + 1) : nil
                                )
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 12)
            .foregroundStyle(.netflixWhite)
        }
    }

}

#Preview {
    RouterView { _ in
        NetflixHomeView()
            .environmentObject(DeveloperPreview().homeVM)
    }
}

