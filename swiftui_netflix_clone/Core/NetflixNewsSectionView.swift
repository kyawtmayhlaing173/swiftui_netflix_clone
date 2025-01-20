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
    @State private var categoryScrollTarget: Int?
    
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
                LazyVStack {
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
                            proxy.scrollTo(target, anchor: .bottom)
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .onScrollGeometryChange(for: Double.self) { geo in
            geo.contentOffset.y
        } action: { oldValue, newValue in
            withAnimation {
                scrollViewOffset = newValue
                let number = max(scrollViewOffset/500, 0)
                let currentItem = Int(round(number))
                updateSelectedFilter(currentItem: currentItem)
            }
        }
    }
    
    private func updateSelectedFilter(currentItem: Int) {
        if (currentItem >= 0 && currentItem < 11) {
            selectedFilter = FilterModel.newsMockArray[0]
            categoryScrollTarget = 0
        } else if (currentItem >= 11 && currentItem < 21) {
            selectedFilter = FilterModel.newsMockArray[1]
            categoryScrollTarget = 1
        } else {
            selectedFilter = FilterModel.newsMockArray[2]
            categoryScrollTarget = 2
        }
    }
    
    private var fullHeaderwithFilter: some View {
        LazyVStack(spacing: 0) {
            if scrollViewOffset < 0 {
                NetflixHeaderView(title: "For You")
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
            }
            
            ScrollView(.horizontal) {
                ScrollViewReader { proxy in
                    LazyHStack {
                        ForEach(Array(FilterModel.newsMockArray.enumerated()), id: \.offset) { index, filter in
                            NetflixNewsFilterCell(
                                title: filter.title,
                                iconName: filter.iconName,
                                isSelected: selectedFilter == filter
                            )
                            .onChange(of: categoryScrollTarget) { oldTarget, newTarget in
                                if let target = newTarget {
                                    categoryScrollTarget = nil
                                    withAnimation {
                                        proxy.scrollTo(target, anchor: .leading)
                                    }
                                }
                            }
                            .onTapGesture {
                                selectedFilter = filter
                                withAnimation(.easeInOut(duration: 3)) {
                                    scrollTarget = index * 10
                                }
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
