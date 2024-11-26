//
//  FavoritesService.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation
import CoreData.NSManagedObjectContext

final class FavoritesService {
    
    static let shared = FavoritesService()
    
    private let context: NSManagedObjectContext
    
    private init(context: NSManagedObjectContext = DatabaseManager.shared.context) {
        self.context = context
    }
    
    func addToFavorites(course: Course) {
        let favorite = Favorite(context: context)
        favorite.id = course.id
        favorite.name = course.name
        favorite.instructor = course.instructor
        favorite.thumbnail = course.thumbnail
        favorite.category = course.category
        favorite.video = course.video
        favorite.desc = course.description
        favorite.createdAt = course.createdAt
        favorite.userId = CurrentUserService.shared.getCurrentUser()?.id
        save()
    }

    func getFavorites() -> [Favorite] {
        do {
            let request = NSFetchRequest<Favorite>(entityName: "Favorite")
            return try context.fetch(request).filter { $0.userId == CurrentUserService.shared.getCurrentUser()?.id }
        } catch {
            print("Failed to fetch favorites: \(error.localizedDescription)")
            return []
        }
    }
    
    func isCourseFavorite(courseId: String) -> Bool {
        return (get(id: courseId) != nil)
    }

    func removeFromFavorites(id: String) {
        if let favoriteCourse = getFavorites().first(where: { $0.id == id }) {
            context.delete(favoriteCourse)
            save()
        }
    }
    
    private func get(id: String) -> Favorite? {
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Fetch error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("CoreData save failed. \(error.localizedDescription)")
            }
        }
    }
    
    func delete() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorite")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete all favorites: \(error)")
        }
    }
}
