//
//  CourseService.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

final class CourseService {
    
    static let shared = CourseService()
    
    private let courseAPI: CourseAPIServiceProtocol
    private let favoritesService: FavoritesService
    
    private init(courseAPI: CourseAPIServiceProtocol = CourseAPIService.shared,
         favoritesService: FavoritesService = FavoritesService.shared) {
        self.courseAPI = courseAPI
        self.favoritesService = favoritesService
    }
    
    func getCourses(completion: @escaping ([Course]) -> Void) {
        var courses: [Course] = []
        
        courseAPI.fetchCourses { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let data):
                let tempCourses = data ?? []
                let favorites = self.favoritesService.getFavorites().compactMap { $0.id }
                courses = tempCourses.map {
                    $0.toCopy(isFavorite: favorites.contains($0.id))
                }
                completion(courses)
            case .failure(let failure):
                print(failure)
                completion([])
            }
        }
    }
    
    func getSearchedCourses(query: String, completion: @escaping ([Course]) -> Void) {
        var courses: [Course] = []
        
        courseAPI.fetchSearchedCourses(query: query) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let data):
                let tempCourses = data ?? []
                let favorites = self.favoritesService.getFavorites().compactMap { $0.id }
                courses = tempCourses.map {
                    $0.toCopy(isFavorite: favorites.contains($0.id))
                }
                completion(courses)
            case .failure(let failure):
                print(failure)
                completion([])
            }
        }
    }
    
    func getFavoriteCourses(completion: ([Course]) -> Void) {
        let favorites = self.favoritesService.getFavorites()
        let courses = favorites.map {
            $0.toCourse()
        }
        completion(courses)
    }
}
