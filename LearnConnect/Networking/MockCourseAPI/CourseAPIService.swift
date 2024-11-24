//
//  CourseAPIService.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

protocol CourseAPIServiceProtocol {
    func fetchCourses(completion: @escaping (Result<[Course]?, NetworkError>) -> Void)
}

final class CourseAPIService: CourseAPIServiceProtocol {
    
    static let shared = CourseAPIService()
    
    private init () {}
        
    func fetchCourses(completion: @escaping (Result<[Course]?, NetworkError>) -> Void) {
        NetworkManager.shared.request(MockCourseAPI.getCourses, type: [Course].self) { results in
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
