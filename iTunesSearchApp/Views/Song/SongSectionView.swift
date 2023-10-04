//
//  SongSectionView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct SongSectionView: View {
    
    let songs: [Song]
    let rows = Array(repeating: GridItem(.fixed(60), spacing: 0, alignment: .leading), count: 4)
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 16) {
                ForEach(songs) { song in
                    HStack {
                        SongRowView(song: song)
                            .frame(width: 300)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    SongSectionView(songs: [Song.mock])
}
