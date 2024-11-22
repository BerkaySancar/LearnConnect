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
    
    func getUsers() -> [User] {
        do {
            let users = try persistedContainer.viewContext.fetch(NSFetchRequest<User>(entityName: "User"))
            return users
        } catch {
            fatalError("CoreData fetch data failed. \(error.localizedDescription)")
        }
    }
    
    func addUser(name: String, surname: String, email: String, password: String) {
        let user = User(context: context)
        user.id = UUID().uuidString
        user.name = name
        user.surname = surname
        user.email = email
        user.password = password
        save()
    }
    
    func deleteAllUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete all users: \(error)")
        }
    }
    
    func deleteUser(user: User) {
        context.delete(user)
        save()
    }
}
