//
//  DatabaseManager.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 22.11.2024.
//

import CoreData
import Foundation

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let persistedContainer = NSPersistentContainer(name: "Database")
    private var context: NSManagedObjectContext {
        return persistedContainer.viewContext
    }
    
    private init() {
        persistedContainer.loadPersistentStores(completionHandler: { _, error in
            if let error {
                fatalError("CoreData load failed. \(error.localizedDescription)")
            }
        })
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
            let users = try persistedContainer.viewContext.fetch(NSFetchRequest<User>(entityName: "User"))
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
}
