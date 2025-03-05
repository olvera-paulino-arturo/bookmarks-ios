//
//  Codable+Extensions.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import Foundation


extension Encodable  {
    func toData() -> Data? {
        if let encodedData = try? JSONEncoder().encode(self) {
            return encodedData
        }
        return nil
    }
    
    func toDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return dictionary
        } catch {
            return nil
        }
    }
    
}
