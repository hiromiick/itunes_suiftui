//
//  AlbumListView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/03.
//

import SwiftUI

struct AlbumListView: View {
    
    @Bindable var viewModel: AlbumListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.albums) { album in
                NavigationLink {
                    AlbumDetailView(album: album)
                } label: {
                    AlbumRowView(album: album)
                }
            }
            switch viewModel.state {
            case .default:
                Color.clear
                    .task {
                        await viewModel.loadMore()
                    }
            case .isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case .loadedAll:
                Color.gray
            case .error(let message):
                Text(message)
                    .foregroundColor(.pink)
            }
        }
        .listStyle(.plain)
    }
}


#Preview {
    NavigationView {
        AlbumListView(viewModel: AlbumListViewModel.example())
    }
}
