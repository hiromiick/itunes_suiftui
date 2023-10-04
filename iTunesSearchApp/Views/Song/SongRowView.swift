//
//  SongRowView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct SongRowView: View {
    
    let song: Song
    
    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.maximumFractionDigits = 2
        return f
    }
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: song.artworkUrl60 ?? "", size: 60)
            
            VStack(alignment: .leading) {
                Text(song.trackName ?? "")
                Text(song.artistName + " - " + song.collectionName)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
            
            Spacer(minLength: 20)
            
            if let urlString = song.trackViewURL,
               let url = URL(string: urlString),
               let price = song.trackPrice {
                Link(destination: url, label: {
                    Text("\(formatter.string(from: price as NSNumber) ?? "")\(song.currency)")
                })
                .buttonStyle(BuyButtonStyle())
            }
        }
    }
}

#Preview {
    SongRowView(song: Song.mock)
}
