//
//  MoviesRequest.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import Foundation

struct MoviesRequest: Codable, Parserable {
    
    let language: String
    
    
    enum CodingKeys: String, CodingKey {
        case language
    }
    
    func toQueryParams() ->  [URLQueryItem]{
        return ParseHelper.codableToQueryPath(self)
    }
}
