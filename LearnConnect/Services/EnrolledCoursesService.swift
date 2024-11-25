//
//  EnrolledCoursesService.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 25.11.2024.
//

import CoreData
import Foundation

final class EnrolledCoursesService {
    
    static let shared = EnrolledCoursesService()
    
    private let context: NSManagedObjectContext
    private let currentUserService: CurrentUserService
    
    private init(context: NSManagedObjectContext = DatabaseManager.shared.context, currentUserService: CurrentUserService = .shared) {
        self.context = context
        self.currentUserService = currentUserService
    }
    
    func addCourseToEnrolledCourses(course: Course) {
        let enrolledCourse = EnrolledCourses(context: context)
        enrolledCourse.id = UUID().uuidString
        enrolledCourse.courseId = course.id
        enrolledCourse.userId = currentUserService.getCurrentUser()?.id
        enrolledCourse.thumbnail = course.thumbnail
        enrolledCourse.courseName = course.name
        enrolledCourse.videoDuration = 0.0
        enrolledCourse.videoCurrentTime = 0.0
        enrolledCourse.isCompleted = false
        save()
    }
    
    func getEnrolledCourses() -> [EnrolledCourses] {
        do {
            let request = NSFetchRequest<EnrolledCourses>(entityName: "EnrolledCourses")
            return try context.fetch(request)
        } catch {
            print("Failed to fetch enrolled courses: \(error.localizedDescription)")
            return []
        }
    }
    
    func updateCourseVideoDuration(courseId: String, videoDuration: Double) {
        if let enrolledCourse = getEnrolledCourses().first(where: { $0.courseId == courseId }) {
            enrolledCourse.videoDuration = videoDuration
            save()
        }
    }
    
    func updateCourseVideoCurrentTime(courseId: String, currentTime: Double) {
        if let enrolledCourse = getEnrolledCourses().first(where: { $0.courseId == courseId }) {
            enrolledCourse.videoCurrentTime = currentTime
            save()
        }
    }
    
    func updateCourseCompletion(courseId: String, isCompleted: Bool) {
        if let enrolledCourse = getEnrolledCourses().first(where: { $0.courseId == courseId }) {
            enrolledCourse.isCompleted = isCompleted
            save()
        }
    }
    
    func removeFromEnrolledCourses(id: String) {
        if let enrolledCourse = getEnrolledCourses().first(where: { $0.courseId == id }) {
            context.delete(enrolledCourse)
            save()
        }
    }
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("CoreData save failed. \(error.localizedDescription)")
            }
        }
    }
    
    func delete() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "EnrolledCourses")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete all enrolled courses: \(error)")
        }
    }
}
