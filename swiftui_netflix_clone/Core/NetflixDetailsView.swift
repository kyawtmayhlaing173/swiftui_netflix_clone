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
    var movie: Movie
        
    init(movie: Movie) {
        self.movie = movie
        self._detailVM = StateObject(
            wrappedValue: NetflixDetailsViewModel(
                searchQuery: movie.original_name ?? movie.original_title ?? "",
                movie: movie
            )
        )
    }
    
    var currentYear: Int {
        let year = Calendar.current.component(.year, from: Date())
        return year
    }
    
    var body: some View {
        let year = DateManager().getYearFromDateString(dateString: movie.release_date)

        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                NetflixDetailsHeaderView(youtubeId: detailVM.youtubeId)
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        NetflixDetailsProductView(
                            title: movie.original_name ?? movie.original_title ?? "",
                            isNew: true,
                            yearReleased: String(year),
                            seasonCount: 2,
                            hasClosedCaptions: true,
                            isTopTen: 3,
                            descriptionText: movie.overview,
                            onPlayPressed: {
                                
                            },
                            onDownloadPressed: {
                                
                            },
                            credits: detailVM.movieCredit
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
                        NetflixDetailMoreSection(detailVM: detailVM)
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
