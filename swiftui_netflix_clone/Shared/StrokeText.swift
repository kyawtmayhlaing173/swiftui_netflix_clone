//
//  StrokeText.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 17/01/2025.
//

import SwiftUI

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
    }
}
