//
//  BookmarksViewModel.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import Foundation
import Combine
import CoreData

class BookmarksViewModel: ObservableObject {
    
    private let mainViewModel = MainViewModel.shared
    
    private var cancellables = Set<AnyCancellable>()
    @Published var movies: [Bookmarks] = []
    
    @Published var hasMessage: Bool = false
    @Published var hasError: Bool = false
    @Published var message: String = ""
    
    private let dataManager = CoreDataManager()
    
    private let syncDataHelper = SyncDataHelper()
    
    
    init() {
        mainViewModel.$tabSelection.sink { tab in
            if tab == MainTabs.bookmarks {
                self.movies = self.dataManager.getBookmarks()
            }
        }.store(in: &cancellables)
    }
    
    
    func removeFromFavorites(index: Int) {
        guard index >= 0 && index < movies.count else { return }
        let movie = movies[index]
        syncDataHelper.removeFromFavorites(bookmark: movie)
        movies.remove(at: index)
    }
    
    func reloadMovies() {
        self.movies = self.dataManager.getBookmarks()
    }
    
}
