//
//  NetflixHeaderView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 01/01/2025.
//

import SwiftUI

struct NetflixHeaderView: View {
    @Environment(\.router) var router

    var body: some View {
        HStack(spacing: 0) {
            Text("For Pinky")
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
                        
                    }
            }
        }
        .background(Color.clear)
        .foregroundColor(Color.netflixWhite)
    }
}

#Preview {
    NetflixHeaderView()
}
