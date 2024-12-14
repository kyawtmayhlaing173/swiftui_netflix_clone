//
//  YoutubeView.swift
//  Netflix Clone
//
//  Created by Kyawt May Hlaing on 01/12/2024.
//

import WebKit
import SwiftUI


struct NetflixTrailerView: UIViewRepresentable {
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else {
            return
        }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}

