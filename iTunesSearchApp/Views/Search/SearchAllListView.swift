//
//  SearchAllListView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct SearchAllListView: View {
    
    @Bindable var albumListViewModel: AlbumListViewModel
    @Bindable var songListViewModel: SongListViewModel
    @Bindable var movieListViewModel: MovieListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                HStack {
                    Text("Song")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        SongListView(viewModel: songListViewModel)
                    } label: {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                        
                    }
                }
                .padding(.horizontal)
                
                SongSectionView(songs: songListViewModel.songs)
                
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Text("Album")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        AlbumListView(viewModel: albumListViewModel)
                    } label: {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                        
                    }
                }
                .padding(.horizontal)
                
                AlbumSectionView(albums: albumListViewModel.albums)
                
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Text("Movie")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        MovieListView(viewModel: movieListViewModel)
                    } label: {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                        
                    }
                }
                .padding(.horizontal)
                
                MovieSectionView(movies: movieListViewModel.movies)
            }
        }
    }
}

#Preview {
    SearchAllListView(
        albumListViewModel: AlbumListViewModel.example(),
        songListViewModel: SongListViewModel.example(),
        movieListViewModel: MovieListViewModel.example())
}
