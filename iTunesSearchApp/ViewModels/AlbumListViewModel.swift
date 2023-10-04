//
//  AlbumListViewModel.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/03.
//

import Foundation
import Observation

@Observable
class AlbumListViewModel {
    
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
                albums = []
                Task {
                    await fetchAlbums(for: newValue)
                }
            }
        }
    }
    var albums: [Album] = [Album]()
    var state: FetchState = .default
    
    @ObservationIgnored private let limit: Int = 20
    @ObservationIgnored private var page: Int = 0
    @ObservationIgnored private let service = APIService()
    
    
    #warning("現時点では、combineのdebounceなどは使用出来ないため、常にAPIを発火してしまう。これは自分でAPI使用状況を管理して、API呼び出しをコントロールする必要がある。 eg) isApiLoading")
//    init() {
//        $searchTerm
//            .receive(on: RunLoop.main)
//            .removeDuplicates()
//            .dropFirst()
//            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
//            .sink { [weak self] term in
//                guard let self else { return }
//                state = .default
//                page = 0
//                albums = []
//                Task {
//                    await self.fetchAlbums(for: term)
//                }
//            }.store(in: &subscriptions)
//    }
    
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
