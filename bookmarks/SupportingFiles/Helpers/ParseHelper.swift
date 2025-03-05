//
//  ParseHelper.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import Foundation

struct ParseHelper {
    static func codableToQueryPath(_ value: Encodable) -> [URLQueryItem] {
        var results: [URLQueryItem] = []
        guard let data = value.toData() else {
            return results
        }
        
        guard let parts = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: AnyObject] else {
            return results
        }
        
        for part in parts {
           
            if let value = part.value as? String {
                results.append(URLQueryItem(name: part.key, value: value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ))
            }
            
        }
        return results
    }
    
    static func dataToCodable<T: Codable>(_ dictionary: [String: Any], returnType: T.Type) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let model = try JSONDecoder().decode(T.self, from: jsonData)
            return model
        } catch {
            return nil
        }
    }
}
