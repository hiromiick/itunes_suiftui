//
//  AlbumRowView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct AlbumRowView: View {
    
    let album: Album
    
    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.maximumFractionDigits = 2
        return f
    }
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: album.artworkUrl100, size: 100)
            
            VStack(alignment: .leading) {
                Text(album.collectionName)
                Text(album.artistName)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
            
            Spacer(minLength: 20)
            
            if let urlString = album.collectionViewURL,
               let url = URL(string: urlString),
               let price = album.collectionPrice {
                Link(destination: url, label: {
                    Text("\(formatter.string(from: price as NSNumber) ?? "") \(album.currency ?? "")")
                })
                .buttonStyle(BuyButtonStyle())
            }
        }
    }
}

#Preview {
    AlbumRowView(album: Album.mock)
}
