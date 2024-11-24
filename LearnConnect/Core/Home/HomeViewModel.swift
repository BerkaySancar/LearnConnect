//
//  HomeViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    func getCourses()
    func favTapped(course: Course)
    func getCategories()
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    
    private let courseAPIService: CourseAPIServiceProtocol?
    
    @Published var courses: [Course] = []
    @Published var searchText = ""
    
    init(courseAPIService: CourseAPIServiceProtocol = CourseAPIService()) {
        self.courseAPIService = courseAPIService
        getCourses()
    }
    
    func getCourses() {
        courseAPIService?.fetchCourses { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let data):
                DispatchQueue.main.async {
                    self.courses = data ?? []
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func favTapped(course: Course) {
//        if favoritesManager.isAlreadyFavorite(product: product) {
//            favoritesManager.removeFromFavorites(productId: product.id)
//        } else {
//            favoritesManager.addToFavorite(product: product)
//        }
    }
    
    func getCategories() {
        
    }
}
