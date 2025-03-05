//
//  AppException.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

struct AppException: Error {
    var message: String
    var messageType: MessageType = .console
}
