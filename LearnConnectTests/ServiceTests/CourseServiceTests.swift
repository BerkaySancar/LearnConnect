//
//  CurrentUserServiceTests.swift
//  LearnConnectTests
//
//  Created by Berkay Sancar on 26.11.2024.
//

@testable import LearnConnect
import XCTest

final class CourseServiceTests: XCTestCase {
    var courseService: CourseService!
    var mockCourseAPI: MockCourseAPIService!
    var mockFavoritesService: MockFavoritesService!
    
    override func setUp() {
        super.setUp()
        mockCourseAPI = MockCourseAPIService()
        mockFavoritesService = MockFavoritesService()
        courseService = CourseService(courseAPI: mockCourseAPI, favoritesService: mockFavoritesService)
    }
    
    override func tearDown() {
        courseService = nil
        mockCourseAPI = nil
        mockFavoritesService = nil
        super.tearDown()
    }
    
    func testFetchCoursesSuccess() {
        let mockCourses = [
            Course(
                createdAt: "2024-11-24T01:02:14.794Z",
                name: "Mastering Minimalist Design",
                description: "Learn the principles of minimalist design.",
                instructor: "Jane Doe",
                video: "https://example.com/video.mp4",
                thumbnail: "https://example.com/thumbnail.jpg",
                category: "Design",
                id: "1",
                isFavorite: false
            ),
            Course(
                createdAt: "2024-11-24T01:02:14.794Z",
                name: "Advanced Swift Programming",
                description: "Deep dive into Swift programming.",
                instructor: "John Smith",
                video: "https://example.com/video2.mp4",
                thumbnail: "https://example.com/thumbnail2.jpg",
                category: "Programming",
                id: "2",
                isFavorite: false
            )
        ]
        
        mockCourseAPI.mockCourses = mockCourses
        
        courseService.getCourses { courses in
            XCTAssertEqual(courses.count, 2)
            XCTAssertEqual(courses.first?.name, "Mastering Minimalist Design", "First course name mismatch")
        }
    }
    
    func testFetchCoursesFailure() {
        mockCourseAPI.shouldReturnError = true
        
        let mockCourses = [
            Course(
                createdAt: "2024-11-24T01:02:14.794Z",
                name: "Mastering Minimalist Design",
                description: "Learn the principles of minimalist design.",
                instructor: "Jane Doe",
                video: "https://example.com/video.mp4",
                thumbnail: "https://example.com/thumbnail.jpg",
                category: "Design",
                id: "1",
                isFavorite: false
            ),
            Course(
                createdAt: "2024-11-24T01:02:14.794Z",
                name: "Advanced Swift Programming",
                description: "Deep dive into Swift programming.",
                instructor: "John Smith",
                video: "https://example.com/video2.mp4",
                thumbnail: "https://example.com/thumbnail2.jpg",
                category: "Programming",
                id: "2",
                isFavorite: false
            )
        ]
        
        mockCourseAPI.mockCourses = mockCourses
        
        courseService.getCourses { courses in
            XCTAssertEqual(courses.count, 0)
        }
    }
    
    func testFetchSearchedCourses() {
        let mockCourses = [
            Course(
                createdAt: "2024-11-24T01:02:14.794Z",
                name: "Mastering Minimalist Design",
                description: "Learn the principles of minimalist design.",
                instructor: "Jane Doe",
                video: "https://example.com/video.mp4",
                thumbnail: "https://example.com/thumbnail.jpg",
                category: "Design",
                id: "1",
                isFavorite: false
            ),
            Course(
                createdAt: "2024-11-24T01:02:14.794Z",
                name: "Advanced Swift Programming",
                description: "Deep dive into Swift programming.",
                instructor: "John Smith",
                video: "https://example.com/video2.mp4",
                thumbnail: "https://example.com/thumbnail2.jpg",
                category: "Programming",
                id: "2",
                isFavorite: false
            )
        ]
        mockCourseAPI.mockCourses = mockCourses
        
        courseService.getSearchedCourses(query: "Swift") { courses in
            XCTAssertEqual(courses.count, 1, "Search result count mismatch")
            XCTAssertEqual(courses.first?.name, "Advanced Swift Programming", "Searched course name mismatch")
        }
    }
}
