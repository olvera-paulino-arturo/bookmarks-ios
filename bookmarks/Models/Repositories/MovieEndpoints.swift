//
//  MovieEndpoints.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import Foundation

struct MovieEndpoints {
    //GET
    static let getMovies: Endpoint = Endpoint(path: ServerConfiguration.baseURLString, url: "/movie/now_playing", method: .get)
    

  
}
