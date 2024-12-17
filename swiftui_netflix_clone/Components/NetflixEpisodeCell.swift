//
//  NetflixEpisodeCell.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 16/12/2024.
//

import SwiftUI

struct NetflixEpisodeCell: View {
    var episodeNo: Int?
    var runtime: Int?
    var overview: String?
    var imageUrl: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                if let imageUrl {
                    ZStack {
                        ImageLoaderView(urlString: "\(Constants.imageURL)\(imageUrl)")
                            .frame(width: 120, height: 80)
                            .cornerRadius(10)
                        Image(systemName: "play.circle")
                            .font(.system(size: 30))
                    }
                    .padding(.trailing)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    if let episodeNo {
                        Text("\(episodeNo). Episode \(episodeNo)")
                            .fontWeight(.bold)
                    }
                    
                    if let runtime {
                        Text("\(runtime)m")
                            .foregroundStyle(Color.netflixLightGray)
                    }
                }
                Spacer()
                Image(systemName: "arrow.down")
            }
            .padding(.bottom, 4)
            
            if let overview {
                Text("\(overview)")
                    .foregroundStyle(Color.netflixLightGray)
            }
        }
        .font(.callout)
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixEpisodeCell(
            episodeNo: 1,
            runtime: 43,
            overview: "This is an overview",
            imageUrl: "/wt7gTUWYGpwp7y0zvFnlW3564LK.jpg"
        )
    }
}
