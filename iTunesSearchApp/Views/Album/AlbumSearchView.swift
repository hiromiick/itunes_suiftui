//
//  AlbumSearchView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct AlbumSearchView: View {
    
    @StateObject var viewModel = AlbumListViewModel()
    
    var body: some View {
        NavigationView {
            
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
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
