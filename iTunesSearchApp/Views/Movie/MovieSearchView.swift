//
//  MovieSearchView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct MovieSearchView: View {
    
    @State var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            
            Group {
                if viewModel.searchTerm.isEmpty {
                    MovieSearchPlaceholderView(viewModel: viewModel)
                } else {
                    MovieListView(viewModel: viewModel)
                }
            }
            
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Movie")
        }
    }
}

#Preview {
    MovieSearchView()
}
