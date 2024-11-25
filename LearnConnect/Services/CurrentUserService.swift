//
//  CurrentUserService.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import CoreData.NSManagedObjectContext
import Foundation

final class CurrentUserService {
    
    static let shared = CurrentUserService()
    
    private let context: NSManagedObjectContext
    
    private init(context: NSManagedObjectContext = DatabaseManager.shared.context) {
        self.context = context
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
   
    func getCurrentUser() -> User? {
        do {
            let users = try context.fetch(NSFetchRequest<User>(entityName: "User"))
            return users.first
        } catch {
            fatalError("CoreData fetch data failed. \(error.localizedDescription)")
        }
    }
  
    func addCurrentUser(id: String, name: String, email: String ) {
        let user = User(context: context)
        user.id = id
        user.name = name
        user.email = email
        save()
    }
       
    func deleteCurrentUser() {
        if let user = getCurrentUser() {
            context.delete(user)
            save()
        }
    }
    
    func delete() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete all users: \(error)")
        }
    }
}
