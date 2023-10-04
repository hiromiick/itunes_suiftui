//
//  AlbumDetailView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct AlbumDetailView: View {
    
    let album: Album
    
    @StateObject var songsViewModel: SongsForAlbumListViewModel
    
    init(album: Album) {
        self.album = album
        self._songsViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumId: album.collectionId))
    }
    
    var body: some View {
        VStack {
            HStack {
                ImageLoadingView(urlString: album.artworkUrl100, size: 100)
                
                VStack(alignment: .leading) {
                    Text(album.collectionName)
                    Text(album.artistName)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text(album.primaryGenreName)
                    Text("\(album.trackCount) songs")
                    Text("Released: \(formattedDate(value: album.releaseDate))")
                }
                .lineLimit(1)
                
                Spacer(minLength: 20)
                
                if let urlString = album.collectionViewURL,
                   let url = URL(string: urlString),
                   let price = album.collectionPrice {
                    Link(destination: url, label: {
                        //Text("\(formatter.string(from: price as NSNumber) ?? "") \(album.currency ?? "")")
                        Text(formatterPrice(price: price, currency: album.currency ?? ""))
                    })
                    .buttonStyle(BuyButtonStyle())
                }
            }
            .padding()
            
            SongsForAlbumListView(songsViewModel: songsViewModel)
        }
        .task {
            await songsViewModel.fetch()
        }
    }
    
    func formattedDate(value: String) -> String {
        let formatterGetter = DateFormatter()
        formatterGetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = formatterGetter.date(from: value) else { return "" }
        
        let formatterSetter = DateFormatter()
        formatterSetter.locale = .current
        formatterSetter.dateStyle = .medium
        formatterSetter.timeStyle = .none
        return formatterSetter.string(from: date)
    }
    
    func formatterPrice(price: Double, currency: String) -> String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = currency
        return f.string(from: NSNumber(value: price)) ?? ""
    }
}

#Preview {
    AlbumDetailView(album: Album.mock)
}
