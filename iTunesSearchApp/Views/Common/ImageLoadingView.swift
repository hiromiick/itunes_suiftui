//
//  ImageLoadingView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import SwiftUI

struct ImageLoadingView: View {
    
    let urlString: String
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size)
            case .success(let image):
                image
                    .border(Color(white: 0.8))
            case .failure(_):
                Color.gray
                    .frame(width: size)
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: size)
    }
}


#Preview {
    ImageLoadingView(urlString: Song.mock.artworkUrl30 ?? "", size: 100)
}
