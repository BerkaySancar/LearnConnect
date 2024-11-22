//
//  User+CoreDataProperties.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 22.11.2024.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
