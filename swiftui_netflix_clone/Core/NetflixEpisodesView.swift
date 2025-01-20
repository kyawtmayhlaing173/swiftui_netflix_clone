//
//  NetflixEpisodesView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 16/12/2024.
//

import SwiftUI

struct NetflixEpisodesView: View {
    @ObservedObject var detailVM: NetflixDetailsViewModel
    @State private var selectedSeason: Int = 1
    @Environment(\.router) var router

    var body: some View {
        let seasonCount = detailVM.movie?.number_of_seasons ?? 1
        
        ScrollView{
            HStack {
                if (seasonCount > 1) {
                    Picker("Select Season", selection: $selectedSeason) {
                        ForEach(1...seasonCount, id: \.self) { season in
                            Text("Part \(season)")
                                .tag(season)
                                .foregroundStyle(Color.white)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .foregroundStyle(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.netflixDarkGray)
                    )
                    .labelsHidden()
                    .accentColor(Color.white)
                    .onChange(of: selectedSeason, { oldValue, newValue in
                        if let movieId = detailVM.movie?.id {
                            getSeasonEpisodes(movieId: movieId, season: newValue)
                        }
                    })

                } else {
                    Text(detailVM.movie?.original_title ?? detailVM.movie?.original_name ?? "")
                        .font(.title3)
                }
                
                Spacer()
                Image(systemName: "info.circle.fill")
                    .onTapGesture {
                        onInfoPressed()
                    }
            }
            .foregroundStyle(.netflixWhite)
            
            
            
            LazyVStack {
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
    
    func getSeasonEpisodes(movieId: Int, season: Int) {
        detailVM.getEpisodes(
            with: movieId,
            seasonNo: season
        )
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
        NetflixEpisodesView(
            detailVM: DeveloperPreview().detailsVMForTVShowWithMultipleSeasons
        )
    }
}
