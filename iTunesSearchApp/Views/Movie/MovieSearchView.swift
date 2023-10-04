//
//  MovieSearchView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct MovieSearchView: View {
    
    @StateObject var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            
            Group {
                if viewModel.searchTerm.isEmpty {
                    MoviePlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    MovieListView(viewModel: viewModel)
                }
            }
            
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Movie")
        }
    }
}

struct MoviePlaceholderView: View {
    
    @Binding var searchTerm: String
    let suggestions = ["ocean", "fight"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Trending")
                .font(.title)
            
            ForEach(suggestions, id: \.self) { text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                        .font(.title2)
                }
            }
        }
    }
}

#Preview {
    MovieSearchView()
}
