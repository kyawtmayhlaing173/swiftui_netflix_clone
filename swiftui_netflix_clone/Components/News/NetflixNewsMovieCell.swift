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
            Color.netflixBlack.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                if topTenRanking != nil {
                    topTenRankingContainer
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
        }
    }
    
    private var topTenRankingContainer: some View {
        return ZStack {
            Rectangle()
                .cornerRadius(10)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
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
            }
            .foregroundStyle(.white)
            .offset(x: 0, y: 50)
            
            StrokeText(text: topTenRanking ?? "", width: 2, color: .white)
                .foregroundColor(.netflixDarkRed)
                .font(.system(size: 100, weight: .bold))
                .offset(x: -120, y: 30)
            }
    }
}

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack {
            ZStack {
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            LinearGradient(
                colors: [.black, .netflixDarkRed.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
            .mask(
                Text(text)
                    .fixedSize(horizontal: true, vertical: true)
            )
        }
        .fixedSize(horizontal: true, vertical: true)
    }
}

#Preview {
    @Previewable @State var shouldPlay = false
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        ScrollView {
            NetflixNewsMovieCell(shouldPlay: $shouldPlay)
            NetflixNewsMovieCell(topTenRanking: "01", shouldPlay: $shouldPlay)
        }
    }
}
