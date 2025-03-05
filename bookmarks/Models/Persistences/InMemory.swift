//
//  InMemory.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import Combine

class InMemory: ObservableObject {
    
    static let shared = InMemory()

    @Published var email: String?
    
    func clean() {
        email = nil
    }
}
