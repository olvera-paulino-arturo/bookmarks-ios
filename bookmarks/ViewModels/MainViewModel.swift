//
//  MainViewModel.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import Combine


class MainViewModel: ObservableObject {
    static let shared = MainViewModel()
    
    private let authManager = AuthManager()
    private let dataManager = CoreDataManager()
    private let inMemory = InMemory.shared
    
    @Published var tabSelection: MainTabs = .releases

    func loggout() {
        if(authManager.loggout()) {
            inMemory.clean()
            LanguageHelper.removeLanguage()
            dataManager.deleteAll()
        }
    }

}
