//
//  NetflixFilterBarView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 20/11/2024.
//

import SwiftUI

struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropdown: Bool
    let iconName: String?
    
    static var mockArray: [FilterModel] {
        [
            FilterModel(title: "TV Shows", isDropdown: false, iconName: nil),
            FilterModel(title: "Movies", isDropdown: false, iconName: nil),
            FilterModel(title: "Categories", isDropdown: true, iconName: nil)
        ]
    }
    
    static var newsMockArray: [FilterModel] {
        [
            FilterModel(
                title: "Coming Soon",
                isDropdown: false,
                iconName: "🍿"
            ),
            FilterModel(title: "Everyone's Watching", isDropdown: false, iconName: "🔥"),
            FilterModel(title: "Top 10 TV Shows", isDropdown: false, iconName: "📺"),
            FilterModel(title: "Top 10 Movies", isDropdown: false, iconName: "🎬")
        ]
    }
    
}

struct NetflixFilterBarView: View {
    var filters: [FilterModel] = FilterModel.mockArray;
    var selectedFilter: FilterModel? = nil
    var selectedCategory: String? = nil
    var onXMarkPressed: (() -> Void)? = nil
    var onFilterPressed: ((FilterModel) -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onXMarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                ForEach(filters, id: \.self) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterCell(
                            title: filter.title == "Categories" ? selectedCategory ?? "Categories" : filter.title,
                            isDropdown: filter.isDropdown,
                            isSelected: selectedFilter == filter
                        )
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 16 : 0)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}

fileprivate struct NetflixFilterBarViewPreview: View {
    @State private var filters = FilterModel.newsMockArray
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        NetflixFilterBarView(
            filters: filters,
            selectedFilter: selectedFilter,
            onXMarkPressed: {
                selectedFilter = nil
            },
            onFilterPressed: { newFilter in
                selectedFilter = newFilter
            }
        )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        NetflixFilterBarViewPreview()
    }
}
