//
//  Endpoint.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import Alamofire

struct Endpoint {
    var path: String
    
    var url: String
    
    var method: HTTPMethod
    
    
    var definition: URL? {
        return URL(string: "https://\(path)\(url)")
    }
}
