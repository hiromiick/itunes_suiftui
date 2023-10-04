//
//  EntityType.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation

enum EntityType: String, Identifiable, CaseIterable {
    case all
    case album
    case song
    case movie
    
    var id: String {
        self.rawValue
    }
    
    var name: String {
        return switch self {
        case .all: "ALL"
        case .album: "Albums"
        case .song: "Songs"
        case .movie: " Movies"
        }
    }
}
