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
    
    func fetch() {
        fetchSongs(for: albumId)
    }
    
    private func fetchSongs(for albumId: Int) {
        service.fetchSongs(for: albumId) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .success(let results):
                    var temp = results.results
                    _ = temp.removeFirst()
                    songs = temp
                    state = .default
                case .failure(let error):
                    state = .error("Could not load: \(error.self): \(error.localizedDescription)")
                    print("test: error: \(error)")
                    
                }
            }
        }
    }
    
    static func example() -> SongsForAlbumListViewModel {
        let vm = SongsForAlbumListViewModel(albumId: 255342344)
        vm.songs = [Song.mock]
        return vm
    }
}
