//
//  NetflixDetailsProductView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 25/11/2024.
//

import SwiftUI
import SwiftfulRouting

struct NetflixDetailsProductView: View {
    let title: String
    let isNew: Bool
    let yearReleased: String
    let seasonCount: Int
    let hasClosedCaptions: Bool
    var isTopTen: Int? = 6
    let descriptionText: String
    var creditText: String? = ""
    var credits: [Cast] = []
    let onPlayPressed: (() -> Void)?
    let onDownloadPressed: (() -> Void)?
    @Environment(\.router) var router

    init(
        title: String,
        isNew: Bool?,
        yearReleased: String = "2024",
        seasonCount: Int = 2,
        hasClosedCaptions: Bool = true,
        isTopTen: Int? = 6,
        descriptionText: String? = "",
        onPlayPressed: (() -> Void)? = nil,
        onDownloadPressed: (() -> Void)? = nil,
        credits: [Cast]
    ) {
        self.title = title
        self.isNew = isNew ?? false
        self.yearReleased = yearReleased
        self.seasonCount = seasonCount
        self.hasClosedCaptions = hasClosedCaptions
        self.isTopTen = isTopTen ?? 9
        self.descriptionText = descriptionText ?? ""
        self.creditText = credits.map { $0.name ?? "" }.joined(separator: ", ")
        self.onPlayPressed = onPlayPressed
        self.onDownloadPressed = onDownloadPressed
        self.credits = credits
    }
    
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
                Text("\(seasonCount) Seasons")
                
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
                Text(descriptionText)
                
                if let creditText {
                    HStack {
                        Text(creditText)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Text("...more")
                            
                    }
                    .font(.subheadline)
                    .foregroundStyle(.netflixLightGray)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .onTapGesture {
                router.showScreen(.sheet) { _ in
                    NetflixCreditList(creditList: credits)
                }
            }
                
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
            NetflixDetailsProductView(title: "Arcane", isNew: false, credits: [])
            NetflixDetailsProductView(title: "Arcane", isNew: false, hasClosedCaptions: false, credits: [])
            NetflixDetailsProductView(title: "Arcane", isNew: true, seasonCount: 10, isTopTen: 4, credits: [])
        }
    }
}
