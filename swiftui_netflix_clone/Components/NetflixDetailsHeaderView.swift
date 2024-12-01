//
//  NetflixDetailsHeaderView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 25/11/2024.
//

import SwiftUI
import SwiftfulRouting

struct NetflixDetailsHeaderView: View {
    var progress: Double = 0.2
    var onAirplayPressed: (() -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    var youtubeId: String?
    @Environment(\.router) var router

    var body: some View {
        ZStack {
            YoutubeView(videoId: youtubeId ?? "")
            
            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    Image(systemName: "tv.badge.wifi")
                        .padding(8)
                        .background(Color.netflixDarkGray)
                        .cornerRadius(50)
                        .foregroundStyle(Color.netflixWhite)
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(Color.netflixDarkGray)
                        .cornerRadius(50)
                        .foregroundStyle(Color.netflixWhite)
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
                .padding(8)
                .fontWeight(.bold)
                Spacer()
            }
        }
        .aspectRatio(2, contentMode: .fit)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixDetailsHeaderView()
    }
}
