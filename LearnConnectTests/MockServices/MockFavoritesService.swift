//
//  MockFavoritesService.swift
//  LearnConnectTests
//
//  Created by Berkay Sancar on 26.11.2024.
//

@testable import LearnConnect

struct MockFavorite {
    var createdAt: String
    var name: String
    var desc: String
    var instructor: String
    var video: String
    var thumbnail: String
    var category: String
    var id: String
    var userId: String
}

class MockFavoritesService: FavoritesServiceProtocol {
    
    var mockFavorites: [MockFavorite] = []
    
    func addToFavorites(course: LearnConnect.Course) {
        
    }
    
    func getFavorites() -> [LearnConnect.Favorite] {
        return []
    }
    
    func isCourseFavorite(courseId: String) -> Bool {
        return false
    }
    
    func removeFromFavorites(id: String) {
        
    }
    
    func get(id: String) -> LearnConnect.Favorite? {
        return nil
    }
    
    func save() {
        
    }
    
    func delete() {
        
    }
}
