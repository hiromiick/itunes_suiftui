//
//  AlbumListViewModel.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/03.
//

import Foundation
import Combine

class AlbumListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    @Published var state: FetchState = .default
    
    private let limit: Int = 20
    private var page: Int = 0
    private let service = APIService()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                guard let self else { return }
                state = .default
                page = 0
                albums = []
                Task {
                    await self.fetchAlbums(for: term)
                }
            }.store(in: &subscriptions)
    }
    
    func loadMore() async {
        await fetchAlbums(for: searchTerm)
    }
    
    func fetchAlbums(for searchTerm: String) async {
        guard !searchTerm.isEmpty else { return }
        guard state == .default else { return }
        
        do {
            let results = try await service.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit)
            await MainActor.run {
                for album in results.results {
                    albums.append(album)
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
    
    static func example() -> AlbumListViewModel {
        let vm = AlbumListViewModel()
        vm.albums = [Album.mock]
        return vm
    }
}
