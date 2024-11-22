//
//  SettingsViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    func deleteAccountBy(id: String) {
        DatabaseManager.shared.deleteUser(userId: id)
    }
}
