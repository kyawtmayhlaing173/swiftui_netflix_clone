//
//  NetflixNewsSectionView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 01/01/2025.
//

import SwiftUI

struct NetflixNewsSectionView: View {
    @Environment(\.router) var router
    @State private var scrollViewOffset: CGFloat = 0
    @State private var filters = FilterModel.newsMockArray
    @State private var selectedFilter: FilterModel? = FilterModel.newsMockArray[0]
    @State var shouldPlay = false
    @StateObject private var newsVM = NetflixNewsViewModel()
    @State private var scrollTarget: Int?

    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            scrollViewLayer
            fullHeaderwithFilter
        }
    }
    
    private var scrollViewLayer: some View {
        return ScrollView(.vertical) {
            ScrollViewReader { proxy in
                VStack {
                    Rectangle()
                        .opacity(0)
                        .frame(height: 100)

                    ForEach (Array(newsVM.moviesWithYoutube.enumerated()), id: \.offset) { (index, item) in
                        NetflixNewsMovieCell(
                            videoId: item.youtubeId,
                            title: item.movie.original_name ?? item.movie.original_title,
                            description: item.movie.overview,
                            topTenRanking: "\(index + 1 < 10 ? "0": "")\(index + 1)",
                            shouldPlay: $shouldPlay
                        )
                        .padding(.vertical, 8)
                    }
                }
                .onChange(of: scrollTarget) { oldTarget, newTarget in
                    if let target = newTarget {
                        scrollTarget = nil
                        withAnimation {
                            proxy.scrollTo(target, anchor: .center)
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .onScrollGeometryChange(for: Double.self) { geo in
            geo.contentOffset.y
        } action: { oldValue, newValue in
            scrollViewOffset = newValue
        }
    }
    
    private var fullHeaderwithFilter: some View {
        VStack(spacing: 0) {
            NetflixHeaderView()
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(FilterModel.newsMockArray.enumerated()), id: \.offset) { index, filter in
                        NetflixNewsFilterCell(
                            title: filter.title,
                            iconName: filter.iconName,
                            isSelected: selectedFilter == filter
                        )
                        .onTapGesture {
                            selectedFilter = filter
                            withAnimation(.easeInOut(duration: 3)) {
                                scrollTarget = index * 10
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
            .padding(.bottom)
        }
        .foregroundStyle(Color.netflixWhite)
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
}

#Preview {
    NetflixNewsSectionView()
}
