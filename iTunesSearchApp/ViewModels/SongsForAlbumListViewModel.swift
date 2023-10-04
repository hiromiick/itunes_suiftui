//
//  SongsForAlbumListViewModel.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation

class SongsForAlbumListViewModel: ObservableObject {
    
    let albumId: Int
    @Published var songs = [Song]()
    @Published var state: FetchState = .default
    
    private let service = APIService()
    
    init(albumId: Int) {
        self.albumId = albumId
    }
    
    func fetch() async {
        await fetchSongs(for: albumId)
    }
    
    private func fetchSongs(for albumId: Int) async {
        
        do {
            let results = try await service.fetchSongs(for: albumId)
            await MainActor.run {
                var temp = results.results
                _ = temp.removeFirst()
                songs = temp
                state = .default
            }
        } catch {
            await MainActor.run {
                state = .error("Could not load: \(error.self): \(error.localizedDescription)")
                print("test: error: \(error)")
            }
        }
    }
    
    static func example() -> SongsForAlbumListViewModel {
        let vm = SongsForAlbumListViewModel(albumId: 255342344)
        vm.songs = [Song.mock]
        return vm
    }
}
