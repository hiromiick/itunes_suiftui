//
//  SongsForAlbumListView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct SongsForAlbumListView: View {
    
    @ObservedObject var songsViewModel: SongsForAlbumListViewModel
    
    var body: some View {
        ScrollView {
            
            if songsViewModel.state == .isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Grid(horizontalSpacing: 20) {
                    ForEach(songsViewModel.songs) { song in
                        GridRow {
                            Text("\(song.trackNumber ?? 0)")
                                .font(.footnote)
                                .gridColumnAlignment(.trailing)
                            
                            Text("\(song.trackName ?? "")")
                                .gridColumnAlignment(.leading)
                            
                            Spacer()
                            
                            Text(formatterdDuration(time: song.trackTimeMillis ?? 0))
                                .font(.footnote)
                            
                            Button {
                                print("Button tapped!!")
                            } label: {
                                Text("$1.23")
                            }
                        }
                        Divider()
                    }
                }
                .padding([.vertical, .leading])
            }
        }
    }
    
    func formatterdDuration(time: Int) -> String {
        let timeInSeconds = time / 1000
        let interval = TimeInterval(timeInSeconds)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: interval) ?? ""
    }
}

#Preview {
    SongsForAlbumListView(songsViewModel: SongsForAlbumListViewModel.example())
}
