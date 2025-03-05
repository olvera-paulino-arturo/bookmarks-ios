//
//  CoreDataManager.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import CoreData

struct CoreDataManager {
    let persistenceController = PersistenceController.shared
    
    
    func getBookmarks() -> [Bookmarks] {
        do {
            let moviesData = try persistenceController.container.viewContext.fetch(Bookmarks.fetchRequest())
            return moviesData
        }
        catch {
            print("Error fetching data: \(error)" )
        }
        return []
    }
    
    func getBookmark(id: Int) -> Bookmarks? {
        do {
            let bookmarks = try persistenceController.container.viewContext.fetch(Bookmarks.fetchRequest())
            let bookmark = bookmarks.first { bookmark in
                bookmark.id == Int32(id)
            }
            return bookmark
        }
        catch {
            print("Error find bookmark \(error)")
        }
        return nil
    }
    
   
   
    func addBookmark(id: Int, title: String, overview: String, posterPath: String, releaseDate: String) {
        let bookmark = Bookmarks(context: persistenceController.container.viewContext)
        bookmark.id = Int32(id)
        bookmark.title = title
        bookmark.overview = overview
        bookmark.posterPath = posterPath
        bookmark.releaseDate = releaseDate
        do {
            try persistenceController.container.viewContext.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func deleteBookmark(id: Int) {
        let bookmark = getBookmark(id: id)
        if let bookmarkToDelete = bookmark {
            persistenceController.container.viewContext.delete(bookmarkToDelete)
        }
    }
    
    func deleteAll() {
        let bookmarks = getBookmarks()
        
        for bookmark in bookmarks {
            persistenceController.container.viewContext.delete(bookmark)
        }
    }
}
