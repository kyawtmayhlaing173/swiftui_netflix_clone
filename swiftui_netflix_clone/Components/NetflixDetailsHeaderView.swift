//
//  NetflixDetailsHeaderView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 25/11/2024.
//

import SwiftUI

struct NetflixDetailsHeaderView: View {
    var imageName: String = Constants.randomImage
    var progress: Double = 0.2
    var onAirplayPressed: (() -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            ImageLoaderView(urlString: Constants.randomImage)
                .frame(maxHeight: 200)
                .aspectRatio(contentMode: .fill)
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
                }
                .padding(8)
                .fontWeight(.bold)
                Spacer()
                ProgressView(value: 0.5)
                    .padding(.vertical, 8)
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
