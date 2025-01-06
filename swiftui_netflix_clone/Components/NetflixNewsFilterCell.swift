//
//  NetflixNewsFilterCell.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 05/01/2025.
//

import SwiftUI

struct NetflixNewsFilterCell: View {
    var title: String
    var iconName: String?
    var isSelected: Bool = false
    
    var body: some View {
        HStack {
            if let iconName = iconName {
                Text(iconName)
            }
            Text(title).foregroundColor(Color.netflixWhite)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack {
                Capsule(style: .circular)
                    .fill(.netflixLightGray)
                    .opacity(isSelected ? 1:0)
                Capsule(style:.circular)
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color.netflixWhite)
                
            }
        )
    }
}

#Preview {
    let filter = FilterModel.newsMockArray[0]
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            NetflixNewsFilterCell(
                title: filter.title,
                iconName: filter.iconName,
                isSelected: true
            )
            NetflixNewsFilterCell(
                title: filter.title,
                iconName: filter.iconName,
                isSelected: false
            )
        }
    }
    
}
