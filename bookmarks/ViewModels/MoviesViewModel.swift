//
//  MoviesViewModel.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    private let movieRepository = MovieRepository.shared
    private var cancellables = Set<AnyCancellable>()
    @Published var movies: [Movie] = []
    
    @Published var hasMessage: Bool = false
    @Published var hasError: Bool = false
    @Published var message: String = ""
    
    private let syncDataHelper = SyncDataHelper()
    
    init() {
        loadMovies()
    }
    
    
    func addToFavorites(index: Int) {
        hasMessage = true
        message = NSLocalizedString("addedFavorites", comment: "")
        guard index >= 0 && index < movies.count else { return }
        let movie = movies[index]
        
        syncDataHelper.addToFavorites(movie: movie)
       
    }
    
    
    private func loadMovies() {
        movieRepository.getMovies(movieRequest: MoviesRequest(language: "es"))
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink {
                if let error = AppErrorHelper.containsError($0) {
                    self.hasMessage = error.messageType == .alert
                    self.message = error.message
                    self.hasError = true
                }
            } receiveValue: { result in
                
                self.movies = result.results
            }
            .store(in: &self.cancellables)
    }
    
    func reloadMovies() {
        self.hasMessage = false
        self.hasError = false
        self.message = ""
        self.movies = []
        loadMovies()
    }
}
