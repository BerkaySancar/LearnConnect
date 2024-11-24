//
//  HomeViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    func getCourses()
    func favTapped(course: Course, isFavorite: Bool)
    func getCategories()
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    
    private let courseService: CourseService
    private let favoriteService: FavoritesService
    private let currentUserService: CurrentUserService
    
    @Published var courses: [Course] = []
    @Published var categories: [CategoryModel] = []
    
    @Published var currentUser: User?
    @Published var searchText = ""
    
    init(courseService: CourseService = .shared,
         favoriteService: FavoritesService = .shared,
         currentUserService: CurrentUserService = .shared) {
        self.courseService = courseService
        self.favoriteService = favoriteService
        self.currentUserService = currentUserService
        
        getCategories()
        getCurrentUser()
    }
    
    func getCourses() {
        courseService.getCourses { [weak self] courses in
            guard let self else { return }
            DispatchQueue.main.async {
                self.courses = courses
            }
        }
    }
        
    func favTapped(course: Course, isFavorite: Bool) {
        if isFavorite {
            favoriteService.addToFavorites(course: course)
        } else {
            favoriteService.removeFromFavorites(id: course.id)
        }
        
        let index = courses.firstIndex(where: { $0.id == course.id })
        let updatedCourse = course.toCopy(isFavorite: isFavorite)
        if let index {
            courses.remove(at: index)
            courses.insert(updatedCourse, at: index)
        }
    }
    
    func getCategories() {
        self.categories = [
            .init(name: "Design", image: "category_design"),
            .init(name: "Health", image: "category_health"),
            .init(name: "Sports", image: "category_sports"),
            .init(name: "Software", image: "category_software"),
            .init(name: "Education", image: "category_education")
        ]
    }
    
    func getCurrentUser() {
        self.currentUser = currentUserService.getCurrentUser()
    }
}
