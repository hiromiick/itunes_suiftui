//
//  Movie.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/03.
//

import Foundation


// MARK: - MovieResult
struct MovieResult: Codable {
    let resultCount: Int
    let results: [Movie]
}

// MARK: - Result
struct Movie: Codable, Identifiable {
    let wrapperType, kind: String
    let artistID: Int?
    let trackID: Int
    let artistName, trackName: String
    let trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double?
    let trackRentalPrice, collectionHDPrice, trackHDPrice, trackHDRentalPrice: Double?
    let releaseDate: String
    let trackTimeMillis: Int?
    let country, currency, primaryGenreName, contentAdvisoryRating: String
    let shortDescription, longDescription: String?
    
    var id: Int {
        return trackID
    }

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case trackID = "trackId"
        case artistName, trackName
        case trackViewURL
        case previewURL
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
        case collectionHDPrice
        case trackHDPrice
        case trackHDRentalPrice
        case releaseDate, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, shortDescription, longDescription
    }
    
    static var mock: Movie {
        Movie(wrapperType: "track", kind: "feature-movie", artistID: nil, trackID: 282572461, artistName: "Steven Soderbergh", trackName: "Ocean's Eleven (2001)", trackViewURL: "https://itunes.apple.com/us/movie/oceans-eleven-2001/id282572461?uo=4", previewURL: "https://video-ssl.itunes.apple.com/itunes-assets/Video123/v4/52/bf/2d/52bf2d67-71d4-d20d-30ee-029171d93f1d/mzvf_5993673306085984455.640x478.h264lc.U.p.m4v", artworkUrl30: "https://is1-ssl.mzstatic.com/image/thumb/Video124/v4/f6/db/ec/f6dbec7c-9d6a-2767-3371-3c14630f988d/pr_source.lsr/30x30bb.jpg", artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Video124/v4/f6/db/ec/f6dbec7c-9d6a-2767-3371-3c14630f988d/pr_source.lsr/60x60bb.jpg", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Video124/v4/f6/db/ec/f6dbec7c-9d6a-2767-3371-3c14630f988d/pr_source.lsr/100x100bb.jpg", collectionPrice: 14.99, trackPrice: 14.99, trackRentalPrice: 3.99, collectionHDPrice: 14.99, trackHDPrice: 14.99, trackHDRentalPrice: 3.99, releaseDate: "2002-02-15T08:00:00Z", trackTimeMillis: 6993472, country: "USA", currency: "USD", primaryGenreName: "Action & Adventure", contentAdvisoryRating: "PG-13", shortDescription: nil, longDescription: "George Clooney, Matt Damon, Brad Pitt, Julia Roberts and Don Cheadle go for broke to pull off the most sophisticated and daring Las Vegas casino heist ever. Less than 24 hours after being paroled, charismatic Danny Ocean (Clooney) handpicks a top-notch team of smooth operators to pocket $150 million--in one night! The mark: ruthless entrepreneur Terry Benedict (Andy Garcia). Benedict controls three of the biggest casinos in Las Vegas ... and Ocean's sexy ex-wife (Roberts). In any other place they'd be bad guys, but Ocean and his crew stick to the rules: Don't hurt anybody. Don't steal from anyone who doesn't deserve it. And play the game like you've got nothing to lose. Are you in or out?")
    }
}
