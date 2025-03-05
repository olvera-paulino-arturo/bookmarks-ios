//
//  CloudDataManager.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import FirebaseFirestore

struct CloudDataManager {
    let db = Firestore.firestore()
    
    
    func addBookmark(collectionName: String, cloudBookmark: CloudBookmark) async {
        guard let bookmark = cloudBookmark.toDictionary() else {
            return
        }
        do {
            let ref = try await db.collection(collectionName).addDocument(data: bookmark)
          print("Document added with ID: \(ref.documentID)")
        } catch {
          print("Error adding document: \(error)")
        }
    }
    
    func getBookmarks(collectionName: String) async -> [CloudBookmark] {
        var list = [CloudBookmark] ()
        do {
            let documents = try await db.collection(collectionName).getDocuments()
           
            for document in documents.documents {
                if let movie = ParseHelper.dataToCodable(document.data(), returnType: CloudBookmark.self) {
                    list.append(movie)
                }
            }
            return list

        } catch {
          print("Error getting documents: \(error)")
            return list
        }
    }
    

    
    func findBookmark(collectionName: String, movieId: Int) async -> String? {
        do {
            let documentResult = try await db.collection(collectionName).whereField("id", isEqualTo: movieId).getDocuments()
            for document in documentResult.documents {
                return document.documentID
            }
        } catch {
          print("Error getting documents: \(error)")
            return nil
        }
        return nil
    }
    
    func removeBookmark(collectionName: String, movieId: Int) async {
        do {
            if let documentId = await findBookmark(collectionName: collectionName, movieId: movieId) {
                try await db.collection(collectionName).document(documentId).delete()
                print("Document successfully removed!")
            }
            else {
                print("Document not found")
            }
          
        } catch {
          print("Error removing document: \(error)")
        }
    }
}
