//
//  NetflixHeaderBanner.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 21/11/2024.
//

import SwiftUI
import SwiftfulRouting

struct NetflixHeroCell: View {
    
    var imageName: String? = Constants.randomImage
    var isNetflixFilm: Bool = true
    var title: String?
    var categories: [Int] = []
    var onBackgroundPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    var onMyListPressed: (() -> Void)? = nil
    var homeVM: NetflixHomeViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(urlString: "https://image.tmdb.org/t/p/w500\(imageName ?? "")")
                .onTapGesture {
                    onBackgroundPressed?()
                }
            
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    if isNetflixFilm {
                        HStack(spacing: 8) {
                            Text("N")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.netflixDarkRed)
                                .font(.largeTitle)
                                .fontWeight(.black)
                            
                            Text("FILM")
                                .kerning(3)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.netflixWhite)
                        }
                    }
                    
                    Text(title ?? "")
                        .font(.system(size: 50, weight: .medium, design: .serif))
                        .multilineTextAlignment(.center)
                }
                
                HStack(spacing: 8) {
                    ForEach(categories, id: \.self) { category in
                        Text(homeVM.getGenresNameById(id: category))
                            .font(.callout)
                        
                        if category != categories.last {
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
                    .onTapGesture {
                        onPlayPressed?()
                    }
                    
                    HStack {
                        Image(systemName: "plus")
                        Text("My List")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixWhite)
                    .background(.netflixDarkGray)
                    .cornerRadius(4)
                    .onTapGesture {
                        onMyListPressed?()
                    }
                }
                .font(.callout)
                .fontWeight(.medium)
            }
            .padding(24)
            .background(
                LinearGradient(
                    colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .foregroundStyle(.netflixWhite)
        .cornerRadius(10)
        .aspectRatio(0.8, contentMode: .fit)
    }
}

#Preview {
    NetflixHeroCell(homeVM: DeveloperPreview().homeVM)
        .padding(40)
}
