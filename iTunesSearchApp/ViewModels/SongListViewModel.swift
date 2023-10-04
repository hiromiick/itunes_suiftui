//
//  SongListViewModel.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation
import Observation

@Observable
class SongListViewModel {
    
    @ObservationIgnored var _searchTerm: String = ""
    var searchTerm: String {
        get {
            access(keyPath: \.state)
            return _searchTerm
        }
        
        set {
            withMutation(keyPath: \.state) {
                _searchTerm = newValue
                state = .default
                page = 0
                songs = []
                Task {
                    await fetchSongs(for: newValue)
                }
            }
        }
    }
    var songs: [Song] = [Song]()
    var state: FetchState = .default
    
    @ObservationIgnored private let limit: Int = 20
    @ObservationIgnored private var page: Int = 0
    @ObservationIgnored private let service = APIService()
    
    
    func loadMore() async {
        await fetchSongs(for: searchTerm)
    }
    
    func fetchSongs(for searchTerm: String) async {
        guard !searchTerm.isEmpty else { return }
        guard state == .default else { return }
        
        do {
            let results = try await service.fetchSongs(searchTerm: searchTerm, page: page, limit: limit)
            await MainActor.run {
                for song in results.results {
                    songs.append(song)
                }
                page += 1
                state = results.results.count == limit ? .default : .loadedAll
            }
        } catch {
            await MainActor.run {
                state = .error("Could not load: \(error.self): \(error.localizedDescription)")
            }
        }
    }
    
    static func example() -> SongListViewModel {
        let vm = SongListViewModel()
        vm.songs = [Song.mock]
        return vm
    }
}
