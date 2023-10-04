//
//  ContentView.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AlbumSearchView()
                .tabItem {
                    Label("Album", systemImage: "music.note")
                }
            
            MovieSearchView()
                .tabItem {
                    Label("Movie", systemImage: "tv")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
