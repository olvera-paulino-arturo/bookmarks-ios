//
//  Language.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//
struct Languages: Codable {
    let languages: [Language]
}

struct Language: Codable {
    
    let code: String
    let name: String
    let native: String
    
}
