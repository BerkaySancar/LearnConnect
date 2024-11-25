//
//  CourseDetailVM.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

final class CourseDetailVM: ObservableObject {
    
    private let favoriteService: FavoritesService
    private let enrolledCoursesService: EnrolledCoursesService
    
    @Published var course: Course
    @Published var isJoined: Bool = false
    @Published var showJoinedAlert: Bool = false
    
    init(course: Course,
         favoriteService: FavoritesService = .shared,
         enrolledCoursesService: EnrolledCoursesService = .shared) {
        self.course = course
        self.favoriteService = favoriteService
        self.enrolledCoursesService = enrolledCoursesService
        
        isJoined = enrolledCoursesService.getEnrolledCourses().contains(where: {$0.courseId == course.id})
    }
    
    func addToFavoriteTapped() {
        if course.isFavorite {
            favoriteService.removeFromFavorites(id: course.id)
        } else {
            favoriteService.addToFavorites(course: course)
        }
        
        let updatedCourse = course.toCopy(isFavorite: !course.isFavorite)
        self.course = updatedCourse
    }
    
    func joinCourseTapped() {
        if self.enrolledCoursesService.getEnrolledCourses().contains(where: {$0.courseId == course.id}) {
            self.isJoined.toggle()
            enrolledCoursesService.removeFromEnrolledCourses(id: course.id)
        } else {
            self.isJoined.toggle()
            enrolledCoursesService.addCourseToEnrolledCourses(course: course)
            showJoinedAlert.toggle()
        }
    }
}
