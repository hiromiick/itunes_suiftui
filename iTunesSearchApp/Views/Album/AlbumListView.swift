//
//  AlbumListView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/03.
//

import SwiftUI

struct AlbumListView: View {
    
    @ObservedObject var viewModel: AlbumListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.albums) { album in
                AlbumRowView(album: album)
            }
            switch viewModel.state {
            case .default:
                Color.clear
                    .onAppear {
                        viewModel.loadMore()
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
    AlbumListView(viewModel: AlbumListViewModel())
}
