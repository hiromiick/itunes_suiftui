//
//  SearchAllListView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct SearchAllListView: View {
    
    @ObservedObject var albumListViewModel: AlbumListViewModel
    @ObservedObject var songListViewModel: SongListViewModel
    @ObservedObject var movieListViewModel: MovieListViewModel
    
    var body: some View {
        VStack {
            Text("Search all")
            Text("Movies: \(movieListViewModel.movies.count)")
            Text("Albums: \(albumListViewModel.albums.count)")
            Text("Songs: \(songListViewModel.songs.count)")
        }
    }
}

#Preview {
    SearchAllListView(
        albumListViewModel: AlbumListViewModel(),
        songListViewModel: SongListViewModel(),
        movieListViewModel: MovieListViewModel())
}
