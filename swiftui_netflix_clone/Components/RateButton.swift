//
//  RateButton.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 26/11/2024.
//

import SwiftUI

enum RateOption: String, CaseIterable {
    case dislike, like, love
    
    var title: String {
        switch self {
        case .dislike:
            return "Not for me"
        case .like:
            return "I like this"
        case .love:
            return "Love this!"
        }
    }
    
    var iconName: String {
        switch self {
        case .dislike:
            return "hand.thumbsdown"
        case .like:
            return "hand.thumbsup"
        case .love:
            return "bolt.heart"
        }
    }
}

struct RateButton: View {
    @State private var showPopover: Bool = false
    var onRatingSelected: ((RateOption) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "hand.thumbsup")
                .font(.title2)
            Text("Rate")
                .font(.caption)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            showPopover.toggle()
        }
        .popover(
            isPresented: $showPopover,
            content: {
                ZStack {
                    Color.netflixDarkGray.ignoresSafeArea()
                    LazyHStack(spacing: 12) {
                        ForEach(RateOption.allCases, id: \.self) {option in
                            rateButton(option: option)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .presentationCompactAdaptation(.popover)
            }
        )
    }
    
    
    private func rateButton(option: RateOption) -> some View {
        VStack(spacing: 8) {
            Image(systemName: option.iconName)
                .font(.title2)
            Text(option.title)
                .font(.caption)
        }
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            showPopover = false
            onRatingSelected?(option)
        }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        RateButton()
    }
}
