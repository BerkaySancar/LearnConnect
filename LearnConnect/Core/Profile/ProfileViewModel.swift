//
//  ProfileViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    private let enrolledCoursesService: EnrolledCoursesService
    private let currentUserService: CurrentUserService
    
    @Published var enrolledCourses: [EnrolledCourses] = []
    var currentUser: User?
    
    var enrolledCourseCount: Int {
        return enrolledCourses.count
    }
    
    var completedCourseCount: Int {
        return enrolledCourses.filter { $0.isCompleted }.count
    }
    
    var progressPercentage: Int {
        guard enrolledCourseCount > 0 else { return 1 }
        return Int((Double(completedCourseCount) / Double(enrolledCourseCount) * 100))
    }
    
    init(enrolledCoursesService: EnrolledCoursesService = .shared,
         currentUserService: CurrentUserService = .shared) {
        self.enrolledCoursesService = enrolledCoursesService
        self.currentUserService = currentUserService
        
        getCurrentUser()
    }
    
    func getEnrolledCourses() {
        self.enrolledCourses = enrolledCoursesService.getEnrolledCourses().filter { $0.userId == currentUser?.id }
    }
    
    func getCurrentUser() {
        self.currentUser = self.currentUserService.getCurrentUser()
    }
    
    func calculateProgress(for course: EnrolledCourses) -> Int {
        guard course.videoDuration > 0 else { return 1 }
        return Int((course.videoCurrentTime / course.videoDuration) * 100)
    }
}
