//
//  CoreDataManager.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 22.11.2024.
//

import Foundation
import CoreData

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
        save()
    }
        
    func deleteUser(user: User) {
        context.delete(user)
        save()
    }
}

