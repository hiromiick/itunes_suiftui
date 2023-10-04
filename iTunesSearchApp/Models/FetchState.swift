//
//  FetchState.swift
//  iTunesSearchApp
//
//  Created by hiromiick on 2023/10/04.
//

import Foundation

enum FetchState: Comparable {
    case `default`
    case isLoading
    case loadedAll
    case error(String)
}
