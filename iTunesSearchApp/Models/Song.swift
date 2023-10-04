//
//  Song.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/03.
//

import Foundation


// MARK: - SongResult
struct SongResult: Codable {
    let resultCount: Int
    let results: [Song]
}

// MARK: - Result
struct Song: Codable, Identifiable {
    let wrapperType: String
    let artistID, collectionID: Int
    let trackID: Int?
    let artistName, collectionName: String
    let trackName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let trackCount: Int
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country, currency, primaryGenreName: String
    let collectionArtistName: String?

    var id: Int {
        return trackID ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName
        case artistViewURL
        case collectionViewURL
        case trackViewURL = "trackViewUrl"
        case previewURL
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, collectionArtistName
    }
    
    static var mock: Song {
        Song(wrapperType: "track", artistID: 316069, collectionID: 255342344, trackID: 255343130, artistName: "Alicia Keys", collectionName: "The Diary of Alicia Keys", trackName: "If I Ain't Got You", artistViewURL: "https://music.apple.com/us/album/if-i-aint-got-you/255342344?i=255343130&uo=4", collectionViewURL: "https://music.apple.com/us/album/if-i-aint-got-you/255342344?i=255343130&uo=4", trackViewURL: "https://music.apple.com/us/album/if-i-aint-got-you/255342344?i=255343130&uo=4", previewURL: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview126/v4/a8/7c/8c/a87c8c75-7a0e-96d6-15eb-dbd6c6ae3f56/mzaf_16672200196759368336.plus.aac.p.m4a", artworkUrl30: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/c2/07/c6/c207c6ee-e3f1-cad2-1259-69a3ebd08b5c/828765571227.jpg/30x30bb.jpg", artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/c2/07/c6/c207c6ee-e3f1-cad2-1259-69a3ebd08b5c/828765571227.jpg/60x60bb.jpg", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/c2/07/c6/c207c6ee-e3f1-cad2-1259-69a3ebd08b5c/828765571227.jpg/100x100bb.jpg", collectionPrice: 9.99, trackPrice: 1.29, releaseDate: "2003-12-02T08:00:00Z", trackCount: 15, trackNumber: 6, trackTimeMillis: 228707, country: "USA", currency: "USD", primaryGenreName: "R&B/Soul", collectionArtistName: nil)
    }
}
