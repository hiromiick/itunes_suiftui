//
//  APIError.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError?)
    case unkown
    
    var description: String {
        return switch self {
        case .badURL: "badUrl"
        case .urlSession(let error): "urlSession error: \(error.debugDescription)"
        case .badResponse(let status): "bad response: \(status)"
        case .decoding(let error): "decoding error: \(String(describing: error))"
        case .unkown: "unkown error"
        }
    }
    
    var localizedDescription: String {
        return switch self {
        case .badURL, .unkown: "something when wrong"
        case .urlSession(let error): error?.localizedDescription ?? "something when wrong"
        case .badResponse(_): "something when wrong"
        case .decoding(let error): error?.localizedDescription ?? "something when wrong"
        }
    }
}
