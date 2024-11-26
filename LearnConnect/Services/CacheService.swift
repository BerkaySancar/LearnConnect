//
//  CacheService.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 26.11.2024.
//

import Foundation

enum CacheType: String {
    case coursesFromAPI = "apiCourses"
}

protocol CacheServiceProtocol {
    func addItem<T: Codable>(key: CacheType, item: T)
    func getItem<T: Codable>(key: CacheType, type: T.Type) -> T?
    func removeItem(key: CacheType)
}

final class CacheService: CacheServiceProtocol {
    
    static let shared = CacheService()
    
    private let userDefaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private init() { }
    
    func addItem<T: Codable>(key: CacheType, item: T) {
        let encodedData = try? encoder.encode(item)
        userDefaults.set(encodedData, forKey: key.rawValue)
    }
    
    func getItem<T: Codable>(key: CacheType, type: T.Type) -> T? {
        if let data = userDefaults.data(forKey: key.rawValue),
           let decodedItem = try? decoder.decode(type, from: data) {
            return decodedItem
        }
        return nil
    }
    
    func removeItem(key: CacheType) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
