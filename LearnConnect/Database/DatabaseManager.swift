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
    
    var context: NSManagedObjectContext {
        return persistedContainer.viewContext
    }
    
    private init() {
        persistedContainer.loadPersistentStores(completionHandler: { _, error in
            if let error {
                fatalError("CoreData load failed. \(error.localizedDescription)")
            }
        })
    }
}
