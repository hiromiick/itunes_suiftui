//
//  APIService.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation

class APIService {
    
    func fetchSongs(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<SongResult, APIError>) -> Void) {
        let url = createURL(for: searchTerm, type: .song, page: page, limit: limit)
        fetch(type: SongResult.self, url: url, completion: completion)
    }
    
    func fetchAlbums(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<AlbumResult, APIError>) -> Void) {
        let url = createURL(for: searchTerm, type: .album, page: page, limit: limit)
        fetch(type: AlbumResult.self, url: url, completion: completion)
    }
    
    func fetchMovies(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<MovieResult, APIError>) -> Void) {
        let url = createURL(for: searchTerm, type: .movie, page: page, limit: limit)
        fetch(type: MovieResult.self, url: url, completion: completion)
    }
    
    func fetch<T: Decodable>(type: T.Type, url: URL?, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url else {
            let error = APIError.badURL
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(.failure(APIError.urlSession(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(APIError.badResponse(response.statusCode)))
            } else if let data {
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(APIError.decoding(error as? DecodingError)))
                }
            }
        }.resume()
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
    
}
