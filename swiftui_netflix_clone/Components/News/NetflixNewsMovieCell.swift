//
//  NetflixNewsMovieCell.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 05/01/2025.
//

import SwiftUI

struct NetflixNewsMovieCell: View {
    var videoId: String = ""
    var title: String? = ""
    var description: String? = ""
    var topTenRanking: String? = nil
    @Binding var shouldPlay: Bool
    var onPlayPressed: (() -> Void)? = nil
    var onMyListPressed: (() -> Void)? = nil

    var body: some View {
        ZStack {
            if topTenRanking != nil {
                topTenRankingContainer
                    .frame(maxWidth: .infinity)
                    .position(x: UIScreen.main.bounds.width / 2.16, y: 20)
                StrokeText(text: topTenRanking ?? "", width: 2, color: .white)
                    .foregroundColor(.netflixWhite)
                    .font(.system(size: 100, weight: .bold))
                    .position(x: 80, y: -20)
            }
            
            VStack(alignment: .leading) {
                NetflixTrailerView(videoId: videoId, shouldPlay: $shouldPlay)
                    .frame(height: 200)
                
                Group {
                    if let title = title {
                        Text(title)
                            .font(.largeTitle)
                    }
                    
                    if let description = description {
                        Text(description)
                            .foregroundStyle(.netflixLightGray)
                    }
                    
                    HStack(spacing: 16) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                        .fontWeight(.bold)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .foregroundStyle(.netflixDarkGray)
                        .background(.netflixWhite)
                        .cornerRadius(4)
                        .onTapGesture {
                            onPlayPressed?()
                        }
                        
                        HStack {
                            Image(systemName: "plus")
                            Text("My List")
                        }
                        .fontWeight(.bold)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .foregroundStyle(.netflixWhite)
                        .background(.netflixDarkGray)
                        .cornerRadius(4)
                        .onTapGesture {
                            onMyListPressed?()
                        }
                    }
                    .padding(.bottom, 16)
                }
                .padding(.horizontal, 16)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.netflixLightGray, lineWidth: 1)

            )
            .cornerRadius(10)
            .foregroundStyle(.netflixWhite)
        }
        .padding(.top, topTenRanking != nil ? 80 : 0)
        .padding(.horizontal, 16)
    }
    
    private var topTenRankingContainer: some View {
        return RoundedRectangle(cornerRadius: 10)
            .stroke(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .netflixWhite, location: 0.0),
                        .init(color: .netflixWhite, location: 0.6),
                        .init(color: .clear, location: 0.8),
                        .init(color: .clear, location: 1.0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                lineWidth: 1
            )
            .fill(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .netflixDarkRed.opacity(0.9), location: 0.0),
                        .init(color: .netflixBlack, location: 0.7)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 100)
    }
}

#Preview {
    @Previewable @State var shouldPlay = false
    var movie = DeveloperPreview().movie
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        ScrollView {
            VStack {
                NetflixNewsMovieCell(
                    videoId: "SiCTXSwqzkw",
                    title: movie.original_name,
                    description: movie.overview,
                    shouldPlay: $shouldPlay
                )
                NetflixNewsMovieCell(
                    videoId: "SiCTXSwqzkw",
                    title: movie.original_name,
                    description: movie.overview,
                    topTenRanking: "15",
                    shouldPlay: $shouldPlay
                )
            }
        }
    }
}
