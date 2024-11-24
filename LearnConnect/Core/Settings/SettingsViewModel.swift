//
//  SettingsViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    func signOutTapped() {
        AuthManager.shared.signOut { results in
            switch results {
            case .success(_):
                DatabaseManager.shared.deleteCurrentUser()
            case .failure(let failure):
                print(failure)
            }
          
        }
    }
    
    func deleteAccountBy(id: String) {
//        DatabaseManager.shared.deleteUser(userId: id)
    }
}
