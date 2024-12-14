//
//  ShareButton.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 26/11/2024.
//

import SwiftUI

struct ShareButton: View {
    var url: String = "https://www.netflix.com/browse"
    
    var body: some View {
        if let url = URL(string: url) {
            ShareLink(item: url) {
                VStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                    Text("Rate")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(Color.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        ShareButton()
    }
}
