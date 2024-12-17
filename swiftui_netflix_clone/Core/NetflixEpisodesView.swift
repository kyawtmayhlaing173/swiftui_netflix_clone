//
//  NetflixEpisodesView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 16/12/2024.
//

import SwiftUI

struct NetflixEpisodesView: View {
    @ObservedObject var detailVM: NetflixDetailsViewModel

    var body: some View {
        ScrollView{
            HStack {
                Text(detailVM.movie?.original_title ?? detailVM.movie?.original_name ?? "")
                    .font(.title3)
                Spacer()
                Image(systemName: "info.circle.fill")
            }
            .foregroundStyle(.netflixWhite)
            VStack {
                ForEach(Array(detailVM.episodes.enumerated()), id: \.offset) { (index, episode) in
                    NetflixEpisodeCell(
                        episodeNo: episode.episode_number ?? index,
                        runtime: episode.runtime,
                        overview: episode.overview,
                        imageUrl: episode.still_path
                    )
                }
            }
            .foregroundStyle(.netflixWhite)
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixEpisodesView(detailVM: DeveloperPreview().detailsVMForTvShow)
    }
}
