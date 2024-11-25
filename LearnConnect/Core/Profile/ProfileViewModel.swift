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
    
    init(enrolledCoursesService: EnrolledCoursesService = .shared,
         currentUserService: CurrentUserService = .shared) {
        self.enrolledCoursesService = enrolledCoursesService
        self.currentUserService = currentUserService
        
        getCurrentUser()
    }
    
    func getEnrolledCourses() {
        self.enrolledCourses = enrolledCoursesService.getEnrolledCourses()
    }
    
    func getCurrentUser() {
        self.currentUser = self.currentUserService.getCurrentUser()
    }
}
