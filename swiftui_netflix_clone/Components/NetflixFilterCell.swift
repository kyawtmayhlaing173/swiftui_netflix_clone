//
//  NetflixFilterCell.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 20/11/2024.
//

import SwiftUI

struct NetflixFilterCell: View {
    var title: String = "Categories"
    var isDropdown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Text(title).foregroundColor(Color.netflixWhite)
            if isDropdown {
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.netflixWhite)
            }
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
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            NetflixFilterCell()
            NetflixFilterCell(isSelected: true)
            NetflixFilterCell(isDropdown: false)
        }
    }
    
}
