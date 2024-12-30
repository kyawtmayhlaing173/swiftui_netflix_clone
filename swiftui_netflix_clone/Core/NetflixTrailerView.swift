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
    @Binding var shouldPlay: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        let controller = WKUserContentController()
        controller.add(context.coordinator, name: "playerReady")
        configuration.userContentController = controller
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .black
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let htmlString = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style>
                body { 
                    margin: 0;
                    background-color: black;
                }
                #player { 
                    position: fixed; 
                    width: 100%; 
                    height: 100%; 
                }
            </style>
        </head>
        <body>
            <div id="player"></div>
            <script>
                // Create YouTube script element
                var tag = document.createElement('script');
                tag.src = "https://www.youtube.com/iframe_api";
                var firstScriptTag = document.getElementsByTagName('script')[0];
                firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
                
                var player;
                function onYouTubeIframeAPIReady() {
                    player = new YT.Player('player', {
                        videoId: '\(videoId)',
                        playerVars: {
                            'playsinline': 1,
                            'controls': 1,
                            'autoplay': 0,
                            'modestbranding': 1,
                            'rel': 0,
                            'showinfo': 0
                        },
                        events: {
                            'onReady': onPlayerReady
                        }
                    });
                }
                
                function onPlayerReady(event) {
                    window.webkit.messageHandlers.playerReady.postMessage('ready');
                }
                
                function playVideo() {
                    if (player) {
                        player.playVideo();
                    } else {
                        print("Player Not Found")
                    }
                }
                
                function pauseVideo() {
                    if (player) {
                        player.pauseVideo();
                    }
                }
            </script>
        </body>
        </html>
        """
        
        uiView.loadHTMLString(htmlString, baseURL: nil)
        
        if shouldPlay {
            context.coordinator.play(uiView)
        } else {
            context.coordinator.pause(uiView)
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: NetflixTrailerView
        
        init(_ parent: NetflixTrailerView) {
            self.parent = parent
            super.init()
        }
        
        func play(_ webView: WKWebView) {
            webView.evaluateJavaScript("playVideo()")
        }
        
        func pause(_ webView: WKWebView) {
            webView.evaluateJavaScript("pauseVideo()")
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "playerReady" {
                if parent.shouldPlay {
                   guard let webView = message.webView else { return }
                   play(webView)
               } else {
                   guard let webView = message.webView else { return }
                   pause(webView)
               }
            }
        }
    }
}

