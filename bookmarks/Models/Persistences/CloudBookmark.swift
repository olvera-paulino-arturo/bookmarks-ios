//
//  CloudBookmark.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

struct CloudBookmark: Codable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    var releaseDate: String
}
