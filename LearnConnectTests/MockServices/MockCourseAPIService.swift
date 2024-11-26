//
//  MockCourseAPIService.swift
//  LearnConnectTests
//
//  Created by Berkay Sancar on 26.11.2024.
//

@testable import LearnConnect

class MockCourseAPIService: CourseAPIServiceProtocol {
    
    var shouldReturnError = false
    var mockCourses: [Course] = []
    
    func fetchCourses(completion: @escaping (Result<[LearnConnect.Course]?, LearnConnect.NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.invalidURL))
        } else {
            completion(.success(mockCourses))
        }
    }
    
    func fetchSearchedCourses(query: String, completion: @escaping (Result<[LearnConnect.Course]?, LearnConnect.NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.invalidURLRequest))
        } else {
            completion(.success(mockCourses.filter { $0.name.contains(query) }))
        }
    }
}
