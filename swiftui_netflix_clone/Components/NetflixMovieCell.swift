//
//  NetflixMovieCell.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 23/11/2024.
//

import SwiftUI

struct NetflixMovieCell: View {
    var width: CGFloat = 90
    var height: CGFloat = 140
    var imageName: String?
    var title: String?
    var isRecentlyAdded: Bool = true
    var topTenRanking: Int? = nil

    var body: some View {
        HStack {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(
                        .system(
                            size: 100,
                            weight: .medium,
                            design: .serif
                        )
                    )
                    .offset(x: 20, y: 20)
            }
                        ZStack(alignment: .bottom) {
                            ImageLoaderView(urlString: "https://image.tmdb.org/t/p/w500\(imageName ?? "")")
                VStack(spacing: 0) {
                    if let title, let firstWord = title.components(separatedBy: " ").first {
                        Text(firstWord)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    
                    Text("Recently Added")
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .padding(.bottom, 2)
                        .frame(maxWidth: .infinity)
                        .background(.netflixDarkRed)
                        .cornerRadius(2)
                        .offset(y: 2)
                        .lineLimit(1)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal, 8)
                        .opacity(isRecentlyAdded ? 1 : 0)
                }
                .padding(.top, 6)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.3),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .cornerRadius(4)
            .frame(width: width, height: height)
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ScrollView {
            NetflixMovieCell(isRecentlyAdded: true, topTenRanking: 1)
            NetflixMovieCell(isRecentlyAdded: false, topTenRanking: 2)
            NetflixMovieCell(isRecentlyAdded: false, topTenRanking: 10)
            NetflixMovieCell(topTenRanking: 10)
            NetflixMovieCell(topTenRanking: 6)
        }
    }
    
}
