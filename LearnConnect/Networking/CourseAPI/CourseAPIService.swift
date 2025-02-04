//
//  CourseAPIService.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

protocol CourseAPIServiceProtocol {
    func fetchCourses(completion: @escaping (Result<[Course]?, NetworkError>) -> Void)
    func fetchSearchedCourses(query: String, completion: @escaping (Result<[Course]?, NetworkError>) -> Void)
}

final class CourseAPIService: CourseAPIServiceProtocol {
    
    func fetchCourses(completion: @escaping (Result<[Course]?, NetworkError>) -> Void) {
        NetworkManager.shared.request(CourseAPI.getCourses, type: [Course].self) { results in
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchSearchedCourses(query: String, completion: @escaping (Result<[Course]?, NetworkError>) -> Void) {
        NetworkManager.shared.request(CourseAPI.searchCourse(query), type: [Course].self) { results in
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
