//
//  SearchViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 25.11.2024.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    private let courseService: CourseServiceProtocol
    private let favoriteService: FavoritesServiceProtocol
    
    @Published var courses: [Course] = []
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init(courseService: CourseServiceProtocol = CourseService(),
         favoriteService: FavoritesServiceProtocol = FavoritesService()) {
        self.courseService = courseService
        self.favoriteService = favoriteService
        
        listenSearchText()
    }
    
    func getSearchedCourses(query: String) {
        courseService.getSearchedCourses(query: query) { [weak self] data in
            guard let self else { return }
            DispatchQueue.main.async {
                self.courses = data
            }
        }
    }
    
    private func listenSearchText() {
        $searchText
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                if newValue.count > 3 {
                    self?.getSearchedCourses(query: newValue)
                } else {
                    self?.courses = []
                }
            }
            .store(in: &cancellables)
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
}
