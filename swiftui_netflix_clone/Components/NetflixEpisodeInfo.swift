//
//  NetflixEpisodeInfo.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 18/12/2024.
//

import SwiftUI

struct NetflixEpisodeInfo: View {
    @ObservedObject var detailVM: NetflixDetailsViewModel
    var title: String
    var onXMarkPressed: (() -> Void)

    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(Color.netflixDarkGray)
                        .cornerRadius(50)
                        .foregroundStyle(Color.netflixWhite)
                        .onTapGesture {
                            onXMarkPressed()
                        }
                }
                .padding()
                Spacer()
            }
            
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                Text("Maturity Rating")
                    .font(.subheadline)
                    .fontWeight(.bold)
                if let rating = detailVM.contentRating {
                    Text("\(rating)")
                        .foregroundStyle(Color.netflixWhite)
                        .font(.system(size: 10))
                        .padding(4)
                        .background(Color.netflixDarkGray)
                        .font(.system(size: 12))
                        .cornerRadius(4)
                }
            }
            .foregroundStyle(Color.netflixWhite)
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixEpisodeInfo(
            detailVM: DeveloperPreview().detailsVMForTvShow,
            title: "Arcane") {
                
            }
    }
}
