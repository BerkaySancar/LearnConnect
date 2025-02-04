//
//  CourseService.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

protocol CourseServiceProtocol {
    func getCourses(completion: @escaping ([Course]) -> Void)
    func getSearchedCourses(query: String, completion: @escaping ([Course]) -> Void)
    func getFavoriteCourses(completion: ([Course]) -> Void)
    func getCoursesFromCache() -> [Course]
}

final class CourseService: CourseServiceProtocol {
    
    private let courseAPI: CourseAPIServiceProtocol
    private let favoritesService: FavoritesServiceProtocol
    
    init(courseAPI: CourseAPIServiceProtocol = CourseAPIService(),
         favoritesService: FavoritesServiceProtocol = FavoritesService()) {
        self.courseAPI = courseAPI
        self.favoritesService = favoritesService
    }
    
    func getCourses(completion: @escaping ([Course]) -> Void) {
        var courses: [Course] = []
        
        courseAPI.fetchCourses { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let data):
                CacheService.shared.addItem(key: .coursesFromAPI, item: data)
                let tempCourses = data ?? []
                let favorites = self.favoritesService.getFavorites().filter {
                    $0.userId == CurrentUserService.shared.getCurrentUser()?.id
                }.compactMap {
                    $0.id
                }
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
    
    func getCoursesFromCache() -> [Course] {
        var courses: [Course] = []
        let coursesFromCache = CacheService.shared.getItem(key: .coursesFromAPI, type: [Course].self) ?? []
        let favorites = self.favoritesService.getFavorites().filter {
            $0.userId == CurrentUserService.shared.getCurrentUser()?.id
        }.compactMap {
            $0.id
        }
        courses = coursesFromCache.map {
            $0.toCopy(isFavorite: favorites.contains($0.id))
        }
        return courses
    }
}
