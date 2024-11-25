//
//  CategoryCoursesVM.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 25.11.2024.
//

import Foundation

final class CategoryCoursesVM: ObservableObject {
    
    private let favoritesService: FavoritesService
    
    @Published var courses: [Course]
    @Published var category: String
    @Published var categoryCourses: [Course] = []
    
    init(courses: [Course], category: String, favoritesService: FavoritesService = .shared) {
        self.courses = courses
        self.category = category
        self.favoritesService = favoritesService
        
        filterCourses()
    }
    
    func filterCourses() {
        self.categoryCourses = self.courses.filter { $0.category == self.category }
    }
    
    func favTapped(course: Course, isFavorite: Bool) {
        if isFavorite {
            favoritesService.addToFavorites(course: course)
        } else {
            favoritesService.removeFromFavorites(id: course.id)
        }
        
        let index = courses.firstIndex(where: { $0.id == course.id })
        let updatedCourse = course.toCopy(isFavorite: isFavorite)
        if let index {
            courses.remove(at: index)
            courses.insert(updatedCourse, at: index)
        }
        
        filterCourses()
    }
}
