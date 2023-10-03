//
//  AlbumListViewModel.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/03.
//

import Foundation
import Combine

// https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&offset=0
// https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5

class AlbumListViewModel: ObservableObject {
    
    enum State: Comparable {
        case `default`
        case isLoading
        case loadedAll
        case error(String)
    }
    
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    @Published var state: State = .default {
        didSet {
            print("sate changed to: \(state)")
        }
    }
    
    let limit: Int = 20
    var page: Int = 0
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                guard let self else { return }
                state = .default
                page = 0
                albums = []
                fetchAlbums(for: term)
            }.store(in: &subscriptions)
    }
    
    func loadMore() {
        fetchAlbums(for: searchTerm)
    }
    
    func fetchAlbums(for searchTerm: String) {
        guard !searchTerm.isEmpty else { return }
        guard state == .default else { return }
        
        let offset = page * limit
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)&offset=\(offset)") else {
            return
        }
        
        print("start fetchnd data for \(searchTerm)")
        state = .isLoading
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("url session error: \(error.localizedDescription)")
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    state = .error("Could not loaded: \(error.localizedDescription)")
                }
            } else if let data {
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        for album in result.results {
                            albums.append(album)
                        }
                        page += 1
                        state = result.results.count == limit ? .default : .loadedAll
                    }
                } catch {
                    print("decoding error \(error)")
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        state = .error("Could not decoded: \(error.localizedDescription)")
                    }
                }
            }
        }.resume()
    }
}
