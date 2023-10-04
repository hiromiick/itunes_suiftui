//
//  APIService.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation

class APIService {
    
    func fetchSongs(searchTerm: String, page: Int, limit: Int) async throws -> SongResult {
        let url = createURL(for: searchTerm, type: .song, page: page, limit: limit)
        return try await fetchAsync(type: SongResult.self, url: url)
    }
    
    func fetchSongs(for albumId: Int) async throws -> SongResult {
        let url = createURL(for: albumId, type: .song)
        return try await fetchAsync(type: SongResult.self, url: url)
    }
    
    func fetchAlbums(searchTerm: String, page: Int, limit: Int) async throws -> AlbumResult {
        let url = createURL(for: searchTerm, type: .album, page: page, limit: limit)
        return try await fetchAsync(type: AlbumResult.self, url: url)
    }
    
    func fetchMovies(searchTerm: String, page: Int, limit: Int) async throws -> MovieResult {
        let url = createURL(for: searchTerm, type: .movie, page: page, limit: limit)
        return try await fetchAsync(type: MovieResult.self, url: url)
    }
    
    func fetchAsync<T: Decodable>(type: T.Type, url: URL?) async throws -> T {
        guard let url else { throw APIError.badURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw APIError.badResponse((response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        guard let result = try? JSONDecoder().decode(type, from: data) else {
            throw APIError.decoding(nil)
        }
        return result
    }
    
    func createURL(for searchTerm: String, type: EntityType, page: Int, limit: Int) -> URL? {
        let baseURL = "https://itunes.apple.com/search"
        let offset = page * limit
        let queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: type.rawValue),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))]
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
    
    func createURL(for id: Int, type: EntityType) -> URL? {
        let baseURL = "https://itunes.apple.com/lookup"
        let queryItems = [
            URLQueryItem(name: "id", value: "\(id)"),
            URLQueryItem(name: "entity", value: type.rawValue)]
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
}
