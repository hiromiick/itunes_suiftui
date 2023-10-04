//
//  Album.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/03.
//

import Foundation


// MARK: - AlbumResult
struct AlbumResult: Codable {
    let resultCount: Int
    let results: [Album]
}

// MARK: - Result
struct Album: Codable, Identifiable {
    let wrapperType, collectionType: String
    let collectionId: Int
    let artistID: Int
    let amgArtistID: Int?
    let artistName, collectionName, collectionCensoredName: String
    let artistViewURL: String?
    let collectionViewURL: String?
    let artworkUrl60, artworkUrl100: String
    let collectionPrice: Double?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright, country, currency: String?
    let releaseDate: String
    let primaryGenreName: String

    enum CodingKeys: String, CodingKey {
        case wrapperType, collectionType
        case collectionId = "collectionId"
        case artistID = "artistId"
        case amgArtistID = "amgArtistId"
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, releaseDate, primaryGenreName
    }
    
    var id: Int {
        return collectionId
    }
    
    static var mock: Album {
        Album(wrapperType: "collection", collectionType: "Album", collectionId: 255342344, artistID: 316069, amgArtistID: 469431, artistName: "Alicia Keys", collectionName: "The Diary of Alicia Keys", collectionCensoredName: "The Diary of Alicia Keys", artistViewURL: "https://music.apple.com/us/artist/alicia-keys/316069?uo=4", collectionViewURL: "https://music.apple.com/us/album/the-diary-of-alicia-keys/255342344?uo=4", artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/c2/07/c6/c207c6ee-e3f1-cad2-1259-69a3ebd08b5c/828765571227.jpg/60x60bb.jpg", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/c2/07/c6/c207c6ee-e3f1-cad2-1259-69a3ebd08b5c/828765571227.jpg/100x100bb.jpg", collectionPrice: 9.99, collectionExplicitness: "notExplicit", trackCount: 15, copyright: "℗ 2003 RCA/JIVE Label Group, a unit of Sony Music Entertainment", country: "USA", currency: "USD", releaseDate: "2003-12-02T08:00:00Z", primaryGenreName: "R&B/Soul")
    }
}
