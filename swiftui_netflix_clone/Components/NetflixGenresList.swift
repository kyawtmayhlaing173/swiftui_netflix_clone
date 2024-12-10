//
//  NetflixCategoriesList.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 09/12/2024.
//

import SwiftUI

struct NetflixGenresList: View {
    var genres: [Genre]
    @Environment(\.router) var router
    let onGenrePressed: ((_ Genre: Genre) -> Void)
    let onXMarkPressed: (() -> Void)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.netflixBlack
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre.name)
                                .foregroundColor(.netflixLightGray)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    onGenrePressed(genre)
                                    router.dismissScreen()
                                }
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
            .frame(maxWidth: .infinity)
            
            // Close Button
            Button(action: {
                router.dismissScreen()
                onXMarkPressed()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.netflixDarkGray)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
            }
            .padding()
        }
        .background(Color.netflixDarkGray)
    }
}

#Preview {
    NetflixGenresList(
        genres: [
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Adventures"),
            Genre(id: 3, name: "Comedy"),
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Adventures"),
            Genre(id: 3, name: "Comedy"),
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Adventures"),
            Genre(id: 3, name: "Comedy"),
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Adventures"),
            Genre(id: 3, name: "Comedy")
        ],
        onGenrePressed: { genreId in },
        onXMarkPressed: { }
    )
}
