//
//  MovieListViewModel.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var movies: [Movie] = [Movie]()
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
                movies = []
                Task {
                    await self.fetchMovies(for: term)
                }
            }.store(in: &subscriptions)
    }
    
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
