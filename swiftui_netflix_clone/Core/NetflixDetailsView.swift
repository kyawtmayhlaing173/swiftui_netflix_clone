//
//  NetflixDetailsView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 25/11/2024.
//

import SwiftUI

struct NetflixDetailsView: View {
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                NetflixDetailsHeaderView()
                NetflixDetailsProductView(
                    title: "Arcane",
                    isNew: true,
                    yearReleased: "2024",
                    seasonCount: 2,
                    hasClosedCaptions: true,
                    isTopTen: 3,
                    descriptionText: "Orphaned sisters Vi and Powder being trouble to Zaun's underground streets in the wake of a heist in post Piltover.",
                    castText: "Cast: Hailee Steinfeld, Ella Purnell, Kevin Alejandro...",
                    onPlayPressed: {
                        
                    },
                    onDownloadPressed: {
                        
                    }
                )
            }
            .foregroundStyle(Color.netflixWhite)
        }
    }
}

#Preview {
    NetflixDetailsView()
}
