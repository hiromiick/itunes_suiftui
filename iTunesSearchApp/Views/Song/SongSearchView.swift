//
//  SongSearchView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct SongSearchView: View {
    
    @StateObject var viewModel = SongListViewModel()
    
    var body: some View {
        NavigationView {
            
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    SongListView(viewModel: viewModel)
                }
            }
            
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Movie")
        }
    }
}

#Preview {
    SongSearchView()
}
