//
//  SearchView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchTerm: String = ""
    @State private var selectedEntityType = EntityType.all
    
    @State private var albumListViewModel = AlbumListViewModel()
    @State private var songListViewModel = SongListViewModel()
    @State private var movieListViewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select the media", selection: $selectedEntityType) {
                    ForEach(EntityType.allCases) { type in
                        Text(type.name)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Divider()
                
                if searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $searchTerm)
                        .frame(maxHeight: .infinity)
                } else {
                    switch selectedEntityType {
                    case .all:
                        SearchAllListView(
                            albumListViewModel: albumListViewModel,
                            songListViewModel: songListViewModel,
                            movieListViewModel: movieListViewModel)
                        .onAppear {
                            albumListViewModel.searchTerm = searchTerm
                            songListViewModel.searchTerm = searchTerm
                            movieListViewModel.searchTerm = searchTerm
                        }
                    case .album:
                        AlbumListView(viewModel: albumListViewModel)
                            .onAppear {
                                albumListViewModel.searchTerm = searchTerm
                            }
                    case .song:
                        SongListView(viewModel: songListViewModel)
                            .onAppear {
                                songListViewModel.searchTerm = searchTerm
                            }
                    case .movie:
                        MovieListView(viewModel: movieListViewModel)
                            .onAppear {
                                movieListViewModel.searchTerm = searchTerm
                            }
                    }
                }
                
                Spacer()
            }
            .searchable(text: $searchTerm)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: searchTerm) { oldValue, newValue in
            switch selectedEntityType {
            case .all:
                albumListViewModel.searchTerm = newValue
                songListViewModel.searchTerm = newValue
                movieListViewModel.searchTerm = newValue
            case .album:
                albumListViewModel.searchTerm = newValue
                
            case .song:
                songListViewModel.searchTerm = newValue
            case .movie:
                movieListViewModel.searchTerm = newValue
            }
        }
    }
}

#Preview {
    SearchView()
}
