//
//  NetflixDetailsProductView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 25/11/2024.
//

import SwiftUI

struct NetflixDetailsProductView: View {
    var title: String = "Arcane"
    var isNew: Bool = true
    var yearReleased: String = "2024"
    var seasonCount: Int? = 2
    var hasClosedCaptions: Bool = true
    var isTopTen: Int? = 6
    var descriptionText: String? = "Orphaned sisters Vi and Powder being trouble to Zaun's underground streets in the wake of a heist in post Piltover."
    var castText: String? = "Cast: Hailee Steinfeld, Ella Purnell, Kevin Alejandro..."
    var onPlayPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 8) {
                if isNew {
                    Text("New")
                        .foregroundStyle(Color.green)
                }
                Text(yearReleased)
                if let seasonCount {
                    Text("\(seasonCount) Seasons")
                }
                
                if hasClosedCaptions {
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGray)
            .frame(maxWidth: .infinity, alignment: .leading)

            
            if let isTopTen {
                HStack(spacing: 4) {
                        topTenIcon
                    
                        Text("#\(isTopTen) in Shows Today")
                            .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // Play Button
            HStack {
                Image(systemName: "play.fill")
                Text("Play")
            }
            .fontWeight(.bold)
            .padding(4)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.netflixDarkGray)
            .background(Color.netflixWhite)
            .cornerRadius(4)
            .onTapGesture {
                
            }
            
            // Download Button
            HStack {
                Image(systemName: "arrow.down.to.line")
                Text("Download")
            }
            .fontWeight(.bold)
            .padding(4)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.netflixWhite)
            .background(.netflixDarkGray)
            .cornerRadius(4)
            .onTapGesture {
                
            }
            
            Group {
                if let descriptionText {
                    Text(descriptionText)
                }
                
                if let castText {
                    Text(castText)
                        .foregroundStyle(.netflixLightGray)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
                
        }
        .padding(16)
        .scrollIndicators(.hidden)
        .foregroundStyle(.netflixWhite)
    }
    
    private var topTenIcon: some View {
        VStack(spacing: 0) {
            Text("Top".uppercased())
                .font(
                    .system(
                        size: 8,
                        weight: .medium,
                        design: .serif
                    )
                )
            Text("10")
                .font(
                    .system(size: 14, weight: .bold)
                )
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .background(Color.netflixDarkRed)
        
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        VStack(spacing: 40) {
            NetflixDetailsProductView()
            NetflixDetailsProductView(isNew: false, seasonCount: nil, hasClosedCaptions: false, isTopTen: nil)
            NetflixDetailsProductView(isNew: true, seasonCount: 10, isTopTen: nil)
        }
    }
}
