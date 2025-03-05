//
//  MovieDetailsViewModel.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import Foundation
import Combine

class MovieDetailsViewModel: ObservableObject {
    
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isFavorite: Bool = false

    private let syncDataHelper = SyncDataHelper()
    

    func checkIsFavorite(movie: Movie) {
        isFavorite = syncDataHelper.hasFavorite(movie: movie)
    }
    
    
    func addToFavorites(movie: Movie) {
        syncDataHelper.addToFavorites(movie: movie)
        
        checkIsFavorite(movie: movie)
    }
    
    func removeFromFavorites(movie: Movie) {
        syncDataHelper.removeFromFavorites(movie: movie)
        checkIsFavorite(movie: movie)
    }
    

}
