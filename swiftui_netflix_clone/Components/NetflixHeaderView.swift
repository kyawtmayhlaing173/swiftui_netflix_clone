//
//  NetflixHeaderView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 01/01/2025.
//

import SwiftUI

struct NetflixHeaderView: View {
    @Environment(\.router) var router
    var title: String
    
    private func onSearchPressed() {
        router.showScreen(.fullScreenCover) { _ in
            NetflixSearchView()
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
            HStack(spacing: 14) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.down.to.line")
                    .onTapGesture {
                        
                    }
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        onSearchPressed()
                    }
            }
        }
        .background(Color.clear)
        .foregroundColor(Color.netflixWhite)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixHeaderView(title: "For Pinky")
    }
}
