//
//  NetflixHeaderBanner.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 21/11/2024.
//

import SwiftUI

struct NetflixHeroCell: View {
    var imageName: String = Constants.randomImage
    var isNetflixFlim: Bool = true
    var title: String = "Arcane"
    var categories: [String] = ["Raunchy", "Romantic", "Comedy"]
    var onBackgroundPressed: (() -> Void)? = nil
    var onMyListPressed: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(urlString: imageName)
            
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    if isNetflixFlim {
                        HStack {
                            Text("N")
                                .foregroundStyle(.netflixDarkRed)
                                .font(.largeTitle)
                                .fontWeight(.black)
                            Text("Flim")
                                .textCase(.uppercase)
                                .kerning(1.0)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.netflixLightGray)
                        }
                    }
                    Text(title)
                        .font(.system(size: 50, weight: .medium, design: .serif))
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .font(.callout)
                            
                            if (category != categories.last) {
                                Circle()
                                    .frame(width: 4, height: 4)
                            }
                        }
                    }
                    HStack(spacing: 16) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .foregroundStyle(.netflixDarkGray)
                        .background(.netflixWhite)
                        .cornerRadius(4)
                        
                        HStack {
                            Image(systemName: "plus")
                            Text("My List")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .foregroundStyle(.netflixWhite)
                        .background(.netflixDarkGray)
                        .cornerRadius(4)
                    }
                    .font(.callout)
                    .fontWeight(.medium)
                }
                .padding(24)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.4)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .foregroundStyle(.netflixWhite)
        .aspectRatio(0.8, contentMode: .fit)
    }
}

#Preview {
    NetflixHeroCell()
}
