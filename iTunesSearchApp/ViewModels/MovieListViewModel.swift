//
//  MovieListViewModel.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation
import Observation

@Observable
class MovieListViewModel {
    
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
                movies = []
                Task {
                    await fetchMovies(for: newValue)
                }
            }
        }
    }
    var movies: [Movie] = [Movie]()
    var state: FetchState = .default
    
    @ObservationIgnored private let limit: Int = 20
    @ObservationIgnored private var page: Int = 0
    @ObservationIgnored private let service = APIService()
    
    func loadMore() async {
        await fetchMovies(for: searchTerm)
    }
    
    func fetchMovies(for searchTerm: String) async {
        guard !searchTerm.isEmpty else { return }
        guard state == .default else { return }
        
        do {
            let results = try await service.fetchMovies(searchTerm: searchTerm, page: page, limit: limit)
            await MainActor.run {
                for movie in results.results {
                    movies.append(movie)
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
    
    static func example() -> MovieListViewModel {
        let vm = MovieListViewModel()
        vm.movies = [Movie.mock]
        return vm
    }
}
