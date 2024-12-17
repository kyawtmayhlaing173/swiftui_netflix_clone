//
//  NetflixDetailsView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 25/11/2024.
//

import SwiftUI

struct NetflixDetailsView: View {
    @State private var isMyList: Bool = false
    @StateObject private var detailVM: NetflixDetailsViewModel
    var mediaType: String
        
    init(movie: Movie) {
        self.mediaType = movie.media_type ?? ""
        self._detailVM = StateObject(
            wrappedValue: NetflixDetailsViewModel(
                searchQuery: movie.original_name ?? movie.original_title ?? "",
                movieId: movie.id,
                mediaType: movie.media_type ?? MediaType.movie.title
            )
        )
    }
    
    var currentYear: Int {
        let year = Calendar.current.component(.year, from: Date())
        return year
    }
    
    var body: some View {
        let released_date = (mediaType == MediaType.tv.title ? detailVM.movie?.first_air_date : detailVM.movie?.release_date) ?? nil
        let year = DateManager().getYearFromDateString(dateString: released_date)
        let currentYear = DateManager().getCurrentYear()
        let seasonCount = (mediaType == MediaType.tv.title ? detailVM.movie?.number_of_seasons : 0) ?? 0

        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                NetflixDetailsHeaderView(youtubeId: detailVM.youtubeId)
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        NetflixDetailsProductView(
                            title: detailVM.movie?.original_title ?? detailVM.movie?.original_name ?? "",
                            isNew: currentYear == year,
                            yearReleased: String(year),
                            seasonCount: seasonCount,
                            hasClosedCaptions: true,
                            isTopTen: 3,
                            descriptionText: detailVM.movie?.overview,
                            onPlayPressed: {
                                
                            },
                            onDownloadPressed: {
                                
                            },
                            credits: detailVM.movieCredit,
                            runtime: detailVM.movie?.runtime ?? 0
                        )
                        HStack(spacing: 32) {
                            MyListButton(
                                isMyList: isMyList) {
                                    isMyList.toggle()
                                }
                            RateButton { selection in
                                    
                                }
                            ShareButton()
                        }
                        .padding(.leading, 32)
                        NetflixDetailMoreSection(
                            detailVM: detailVM,
                            mediaType: mediaType
                        )
                    }
                }
            }
            .foregroundStyle(Color.netflixWhite)
        }
    }
}

#Preview {
    NetflixDetailsView(
        movie: DeveloperPreview().movie
    )
}

#Preview {
    NetflixDetailsView(
        movie: DeveloperPreview().tvShow
    )
}
