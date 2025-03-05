//
//  SplashViewModel.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var isRotating = 0.0
    @Published var path = NavigationPath()
    
    private let syncDataHelper = SyncDataHelper()
    var route: Routes = .auth
    

    init() {
        onNavigate()
    }
    
    func onNavigate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            withAnimation {
                let authManager = AuthManager()
                if(authManager.isLogged()){
                    Task {
                        await self.syncDataHelper.syncLocalData()
                    }
                    self.moveTo(Routes.main)
                }
                else {
                    self.moveTo(Routes.auth)
                }
            }
            
        }
        
    }
    
    func moveTo(_ route: Routes) {
        while(!self.path.isEmpty){
            self.path.removeLast()
        }
        self.path.append(route)
    }
}
