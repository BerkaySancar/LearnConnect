//
//  MockCourseAPI.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

enum MockCourseAPI: URLRequestConvertible {
    
    case getCourses
    
    var baseURL: URL {
        .init(string: "https://674313f1b7464b1c2a6387fe.mockapi.io")!
    }
    
    var path: String {
        switch self {
        case .getCourses:
            "courses"
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .getCourses:
                .get
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var parameters: [String : Any]? {
        nil
    }
}
