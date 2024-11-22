//
//  User+CoreDataClass.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 22.11.2024.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
}

