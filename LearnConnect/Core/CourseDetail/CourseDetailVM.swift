//
//  CourseDetailVM.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

enum CourseDetailAlertType {
    case successAlert
    case warningAlert
}

final class CourseDetailVM: ObservableObject {
    
    private let favoriteService: FavoritesService
    private let enrolledCoursesService: EnrolledCoursesService
    private let currentUserService: CurrentUserService
    
    @Published var course: Course
    @Published var isJoined: Bool = false
    @Published var currentAlert: CourseDetailAlertType = .successAlert
    @Published var showAlert = false
    
    init(course: Course,
         favoriteService: FavoritesService = .shared,
         enrolledCoursesService: EnrolledCoursesService = .shared,
         currentUserService: CurrentUserService = .shared) {
        self.course = course.toCopy(isFavorite: favoriteService.isCourseFavorite(courseId: course.id))
        self.favoriteService = favoriteService
        self.enrolledCoursesService = enrolledCoursesService
        self.currentUserService = currentUserService
        
        isJoined = enrolledCoursesService.getEnrolledCourses().contains(where: { $0.id == course.id })
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
        if self.enrolledCoursesService.getEnrolledCourses().contains(where: { $0.id == course.id }) {
            self.isJoined.toggle()
            enrolledCoursesService.removeFromEnrolledCourses(id: course.id)
        } else {
            self.isJoined.toggle()
            enrolledCoursesService.addCourseToEnrolledCourses(course: course)
            showJoinAlert()
        }
    }
    
    func showLeaveWarningAlert() {
        currentAlert = .warningAlert
        showAlert.toggle()
    }
    
    private func showJoinAlert() {
        currentAlert = .successAlert
        showAlert.toggle()
    }
}
