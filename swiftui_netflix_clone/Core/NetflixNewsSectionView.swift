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
    @State private var selectedFilter: FilterModel? = nil
    @State var shouldPlay = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            scrollViewLayer
            fullHeaderwithFilter
        }
    }
    
    private var scrollViewLayer: some View {
        return ScrollView(.vertical) {
            VStack {
                Rectangle()
                    .opacity(0)
                    .frame(height: 120)
                ForEach (0...5) { index in
                    NetflixNewsMovieCell(shouldPlay: $shouldPlay)
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal, 16)
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
            if scrollViewOffset < 0 {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(FilterModel.newsMockArray, id: \.self) { filter in
                            NetflixNewsFilterCell(
                                title: filter.title,
                                iconName: filter.iconName,
                                isSelected: selectedFilter == filter
                            )
                            .onTapGesture {
                                selectedFilter = filter
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
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
