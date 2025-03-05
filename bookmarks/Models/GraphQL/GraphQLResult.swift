//
//  GraphQLResult.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

struct GraphQLResult<T: Codable>: Codable {
    var data: T
    var errors: [String]?
}

