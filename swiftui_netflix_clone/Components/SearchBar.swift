//
//  SearchBar.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 03/12/2024.
//

import UIKit
import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var vm: SearchViewModel
    
    // Creates the initial UISearchBar
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        
        if let textField = searchBar.searchTextField as? UITextField {
            textField.textColor = .lightGray
            let placeholderText = NSAttributedString(
                string: "Search games, shows, movies...",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
            textField.attributedPlaceholder = placeholderText
            
            // Customize icon color
            if let glassIconView = textField.leftView as? UIImageView {
                glassIconView.tintColor = .gray
            }
            
            if let clearButton = textField.rightView as? UIButton {
                clearButton.tintColor = .red
            }
        }
        return searchBar
    }
    
    // Updates the UISearchBar when binding changes
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    // Creates coordinator to handle UISearchBarDelegate events
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, viewModel: vm)
    }
    
    // Coordinator handles communication between UIKit and SwiftUI
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        var vm: SearchViewModel
        
        init(text: Binding<String>, viewModel: SearchViewModel) {
            _text = text
            self.vm = viewModel
        }
        
        // Updates binding when text changes in search bar
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            if (text.isEmpty) {
                vm.getDiscoverMovie()
            } else {
                vm.searchMovie(with: text)
            }
        }
    }
}
