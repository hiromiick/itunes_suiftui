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
                fetchSongs(for: term)
            }.store(in: &subscriptions)
    }
    
    func loadMore() {
        fetchSongs(for: searchTerm)
    }
    
    func fetchSongs(for searchTerm: String) {
        guard !searchTerm.isEmpty else { return }
        guard state == .default else { return }
        
        service.fetchSongs(searchTerm: searchTerm, page: page, limit: limit) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .success(let results):
                    for song in results.results {
                        songs.append(song)
                    }
                    page += 1
                    state = results.results.count == limit ? .default : .loadedAll
                case .failure(let error):
                    state = .error("Could not load: \(error.self): \(error.localizedDescription)")
                    
                }
            }
        }
    }
}
