//
//  NetflixCreditList.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 05/12/2024.
//

import SwiftUI

struct NetflixCreditList: View {
    var creditList: [Cast]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                Text("Go Ahead")
                    .font(.title)
                Text("Cast")
                    .font(.title3)
                ForEach(creditList, id: \.self) { cast in
                    Text(cast.name ?? "")
                }
            }
            .foregroundStyle(Color.netflixWhite)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixCreditList(creditList: [])
    }
}
