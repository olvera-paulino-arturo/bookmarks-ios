//
//  RouterManager.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI


struct RouterManager {
    
    @ViewBuilder
    static func mainStack(route: Routes, splashViewModel: SplashViewModel) -> some View {
        switch(route) {
            case .auth:
            AuthView()
                .environmentObject(splashViewModel)
            case .main:
            MainView()
                .environmentObject(splashViewModel)
        }
    }
}
