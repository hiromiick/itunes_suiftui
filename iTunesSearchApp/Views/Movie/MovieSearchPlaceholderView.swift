//
//  MovieSearchPlaceholderView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/05.
//

import SwiftUI

struct MovieSearchPlaceholderView: View {
    
    @Bindable var viewModel: MovieListViewModel
    let suggestions = ["klose", "mongol800", "alicia", "christina", "ocean", "fight", "bruno"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Trending")
                .font(.title)
            
            ForEach(suggestions, id: \.self) { text in
                Button {
                    viewModel.searchTerm = text
                } label: {
                    Text(text)
                        .font(.title2)
                }
            }
        }
    }
}

#Preview {
    MovieSearchPlaceholderView(viewModel: MovieListViewModel.example())
}
