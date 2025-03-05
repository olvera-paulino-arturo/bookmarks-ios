//
//  Bookmarks+CoreDataProperties.swift
//  
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//
//

import Foundation
import CoreData


extension Bookmarks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmarks> {
        return NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?

}
