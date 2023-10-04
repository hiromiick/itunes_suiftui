//
//  AlbumSearchView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct AlbumSearchView: View {
    
    @State var viewModel = AlbumListViewModel()
    
    var body: some View {
        NavigationView {
            
            Group {
                if viewModel.searchTerm.isEmpty {
                    AlbumSearchPlaceholderView(viewModel: viewModel)
                } else {
                    AlbumListView(viewModel: viewModel)
                }
            }
            
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Album")
        }
    }
}



#Preview {
    AlbumSearchView()
}
