//
//  EnrolledCourses+CoreDataClass.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 25.11.2024.
//
//

import Foundation
import CoreData

@objc(EnrolledCourses)
public class EnrolledCourses: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EnrolledCourses> {
        return NSFetchRequest<EnrolledCourses>(entityName: "EnrolledCourses")
    }

    @NSManaged public var id: String?
    @NSManaged public var userId: String?
    @NSManaged public var courseId: String?
    @NSManaged public var courseName: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var videoDuration: Double
    @NSManaged public var videoCurrentTime: Double
    @NSManaged public var isCompleted: Bool
}
