//
//  SyncDataHelper.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

struct SyncDataHelper {
    private let dataManager = CoreDataManager()
    private let cloudDataManager = CloudDataManager()
    private let inMemoryData = InMemory.shared
    
    func hasFavorite(movie: Movie) -> Bool {
        return dataManager.getBookmark(id: movie.id) != nil
    }
    
    func addToFavorites(movie: Movie) {
        dataManager.addBookmark(id: movie.id, title: movie.title, overview: movie.overview, posterPath: movie.posterPath, releaseDate: movie.releaseDate)
        let cloudBookmark = CloudBookmark(id: movie.id, title: movie.title, overview: movie.overview, posterPath: movie.posterPath, releaseDate: movie.releaseDate)
        
        if let email = inMemoryData.email {
            Task {
                await cloudDataManager.addBookmark(collectionName: email, cloudBookmark: cloudBookmark)
            }
        }
    }
    
    func syncLocalData() async {
        print("SYNC DATA")
        if let email = inMemoryData.email {
            print("ENTER IN DATA email \(email)")
            let cloudBookmarks = await cloudDataManager.getBookmarks(collectionName: email)
            
            for cloudBookmark in cloudBookmarks {
                let localBookmark = dataManager.getBookmark(id: cloudBookmark.id)
                if (localBookmark == nil ) {
                    dataManager.addBookmark(id: cloudBookmark.id, title: cloudBookmark.title, overview: cloudBookmark.overview, posterPath: cloudBookmark.posterPath, releaseDate: cloudBookmark.releaseDate)
                }
            }
            
        }
    }
    
    func removeFromFavorites(movie: Movie) {
        dataManager.deleteBookmark(id: Int(movie.id))
         
        if let email = inMemoryData.email {
            Task {
                await cloudDataManager.removeBookmark(collectionName: email, movieId: movie.id)
            }
        }
        
    }
    
    func removeFromFavorites(bookmark: Bookmarks) {
        dataManager.deleteBookmark(id: Int(bookmark.id))
        
        if let email = inMemoryData.email {
            Task {
                await cloudDataManager.removeBookmark(collectionName: email, movieId: Int(bookmark.id))
            }
        }
    }
}
