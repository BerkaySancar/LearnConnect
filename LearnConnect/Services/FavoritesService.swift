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
    
//    func addToFavorites(productId: String, name: String) {
//        let favorite = Favorite(context: context)
//        favorite.id = productId
//        favorite.name = name
//        save()
//    }
//
//    func getFavorites() -> [Favorite] {
//        do {
//            let request = NSFetchRequest<Favorite>(entityName: "Favorite")
//            return try context.fetch(request)
//        } catch {
//            print("Failed to fetch favorites: \(error.localizedDescription)")
//            return []
//        }
//    }
//
//    func removeFromFavorites(productId: String) {
//        do {
//            let request = NSFetchRequest<Favorite>(entityName: "Favorite")
//            request.predicate = NSPredicate(format: "id == %@", productId)
//            if let favorite = try context.fetch(request).first {
//                context.delete(favorite)
//                save()
//            }
//        } catch {
//            print("Failed to remove favorite: \(error.localizedDescription)")
//        }
//    }
//
//    private func save() {
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save favorite: \(error.localizedDescription)")
//        }
//    }
}
