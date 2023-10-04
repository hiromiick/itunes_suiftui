//
//  MovieRowView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct MovieRowView: View {
    
    let movie: Movie
    
    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.maximumFractionDigits = 2
        return f
    }
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: movie.artworkUrl100, size: 100)
            
            VStack(alignment: .leading) {
                Text(movie.trackName)
                Text(movie.primaryGenreName)
                    .foregroundStyle(.gray)
                Text(movie.releaseDate)
                    .foregroundStyle(.gray)
                
            }
            .lineLimit(1)
            
            Spacer(minLength: 20)
            
            if let urlString = movie.trackViewURL,
               let url = URL(string: urlString),
               let price = movie.trackPrice {
                Link(destination: url, label: {
                    Text("\(formatter.string(from: price as NSNumber) ?? "")\(movie.currency)")
                })
                .buttonStyle(BuyButtonStyle())
            }
        }
    }
}

#Preview {
    MovieRowView(movie: Movie.mock)
}
