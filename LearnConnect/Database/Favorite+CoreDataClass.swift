//
//  Favorite+CoreDataClass.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//
//

import Foundation
import CoreData

@objc(Favorite)
public class Favorite: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }
    
    @NSManaged public var createdAt: String?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var instructor: String?
    @NSManaged public var video: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var category: String?
    @NSManaged public var id: String?
 
    func toCourse() -> Course {
        return .init(
            createdAt: self.createdAt ?? "",
            name: self.name ?? "",
            description: self.desc ?? "",
            instructor: self.instructor ?? "",
            video: self.video ?? "",
            thumbnail: self.thumbnail ?? "",
            category: self.category ?? "",
            id: self.id ?? "",
            isFavorite: true
        )
    }
}
