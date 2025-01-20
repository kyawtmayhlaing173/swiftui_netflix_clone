//
//  NetflixSearchView.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 03/12/2024.
//

import SwiftUI
import SwiftfulRouting

struct NetflixSearchView: View {
    @State private var searchText = ""
    @FocusState private var focus: Bool
    @StateObject private var searchVM: SearchViewModel
    @Environment(\.router) var router
    
    init() {
        self._searchVM = StateObject(wrappedValue: SearchViewModel())
    }
    
    func onMoviePressed(movie: Movie) {
        router.showScreen(.sheet) { _ in
            NetflixDetailsView(movie: movie)
        }
    }
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "chevron.left")
                        .onTapGesture {
                            router.dismissScreen()
                        }
                    SearchBar(text: $searchText, vm: searchVM)
                }
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        Text("Recommended TV Shows & Movies")
                            .font(.headline)
                            .padding(.bottom)
                        
                        ForEach(Array(searchVM.allMovies.enumerated()), id: \.offset) { (index, movie) in
                            HStack() {
                                NetflixMovieCell(
                                    width: 150,
                                    height: 90,
                                    imageName: movie.poster_path
                                    
                                )
                                Text(movie.original_name ?? movie.original_title ?? "")
                                Spacer()
                                Image(systemName: "play.circle")
                                    .font(.largeTitle)
                            }
                            .onTapGesture {
                                onMoviePressed(movie: movie)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .foregroundStyle(Color.netflixWhite)
            .padding()
            .onAppear {
                focus = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixSearchView()
    }
}
