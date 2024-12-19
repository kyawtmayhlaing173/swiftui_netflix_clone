//
//  NetflixEpisodesView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 16/12/2024.
//

import SwiftUI

struct NetflixEpisodesView: View {
    @ObservedObject var detailVM: NetflixDetailsViewModel
    @Environment(\.router) var router

    var body: some View {
        ScrollView{
            HStack {
                Text(detailVM.movie?.original_title ?? detailVM.movie?.original_name ?? "")
                    .font(.title3)
                Spacer()
                Image(systemName: "info.circle.fill")
                    .onTapGesture {
                        onInfoPressed()
                    }
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
    
    func onInfoPressed() {
        router.showResizableSheet(sheetDetents: [.height(250)], selection: nil, showDragIndicator: false) { _ in
            NetflixEpisodeInfo(
                detailVM: detailVM,
                title: detailVM.movie?.original_name ?? detailVM.movie?.original_title ?? "") {
                    router.dismissEnvironment()
                }
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixEpisodesView(detailVM: DeveloperPreview().detailsVMForTvShow)
    }
}
