//
//  SongListViewModel.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var songs: [Song] = [Song]()
    @Published var state: FetchState = .default
    
    private let limit: Int = 20
    private var page: Int = 0
    private let service = APIService()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                guard let self else { return }
                state = .default
                page = 0
                songs = []
                Task {
                    await self.fetchSongs(for: term)
                }
            }.store(in: &subscriptions)
    }
    
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
