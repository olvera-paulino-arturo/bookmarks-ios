//
//  Parserable.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//


import Foundation

protocol Parserable {
    func toQueryParams() -> [URLQueryItem]
}
