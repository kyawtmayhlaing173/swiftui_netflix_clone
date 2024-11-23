//
//  NetflixHomeView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 20/11/2024.
//

import SwiftUI

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 8) {
                    Rectangle()
                        .frame(height: 120)
                    NetflixHeroCell()
                    categoryRows
                }
            }
            
            VStack(spacing: 0) {
                NetflixHeader()
                    .padding(.horizontal, 16)
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter) {
                        selectedFilter = nil
                    } onFilterPressed: { newFilter in
                        selectedFilter = newFilter
                    }
                    .padding(.top, 16)

                Spacer()
            }
            
        }
    }
    
    private var categoryRows: some View {
        let categories = ["My List", "Today's Top Pick for You", "TV Action & Adventure"];
        let rows = ["1", "2", "3", "4", "5", "6"];
        
        return LazyVStack(spacing: 16) {
            ForEach(Array(categories.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row)
                        .font(.headline)
                        .padding(.horizontal, 1)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(rows.enumerated()), id: \.offset) {(index, product) in
                                NetflixMovieCell(
                                    isRecentlyAdded: Bool.random(),
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
    NetflixHomeView()
}

struct NetflixHeader: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .foregroundColor(Color.netflixWhite)
            HStack(spacing: 14) {
                Image(systemName: "tv.badge.wifi")
                    .foregroundColor(Color.netflixWhite)
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.down")
                    .foregroundColor(Color.netflixWhite)
                    .onTapGesture {
                        
                    }
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.netflixWhite)
                    .onTapGesture {
                        
                    }
            }
        }
    }
}
