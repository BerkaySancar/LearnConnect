//
//  FavoritesViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    private let favoriteService: FavoritesService = .shared
    private let courseService: CourseService = .shared
    
    @Published var courses: [Course] = []
    
    func getCourses() {
        courseService.getFavoriteCourses { [weak self] courses in
            guard let self else { return }
            self.courses = courses
        }
    }
    
    func favTapped(course: Course) {
        favoriteService.removeFromFavorites(id: course.id)
        let index = courses.firstIndex(where: { $0.id == course.id })
        if let index {
            courses.remove(at: index)
        }
    }
}
