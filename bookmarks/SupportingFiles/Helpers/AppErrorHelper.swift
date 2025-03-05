//
//  AppErrorHelper.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import Foundation
import Combine

struct AppErrorHelper {
    
    static func containsError<T>(_ state: Subscribers.Completion<T>) -> T? {
        
        if case .failure(let error) = state {
            return error
        }
        return nil
    }
}
