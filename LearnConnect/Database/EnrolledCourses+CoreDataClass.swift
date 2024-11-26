//
//  EnrolledCourses+CoreDataClass.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 26.11.2024.
//
//

import Foundation
import CoreData

@objc(EnrolledCourses)
public class EnrolledCourses: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EnrolledCourses> {
        return NSFetchRequest<EnrolledCourses>(entityName: "EnrolledCourses")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var thumbnail: String?
    @NSManaged public var userId: String?
    @NSManaged public var videoCurrentTime: Double
    @NSManaged public var videoDuration: Double
    @NSManaged public var createdAt: String?
    @NSManaged public var desc: String?
    @NSManaged public var instructor: String?
    @NSManaged public var video: String?
    @NSManaged public var category: String?
    
    func toCourse() -> Course {
        return .init(
            createdAt: self.createdAt ?? "",
            name: self.name ?? "",
            description: self.desc ?? "",
            instructor: self.instructor ?? "",
            video: self.video ?? "",
            thumbnail: self.thumbnail ?? "",
            category: self.category ?? "",
            id: self.id ?? ""
        )
    }
}

