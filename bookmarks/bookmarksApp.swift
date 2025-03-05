//
//  bookmarksApp.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI


@main
struct bookmarksApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
