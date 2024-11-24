//
//  SettingsViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    func signOutTapped() {
        AuthService.shared.signOut { results in
            switch results {
            case .success(_):
                CurrentUserService.shared.deleteCurrentUser()
//                DatabaseManager.shared.deleteCurrentUser()
            case .failure(let failure):
                print(failure)
            }
          
        }
    }
    
    func deleteAccountBy(id: String) {
//        DatabaseManager.shared.deleteUser(userId: id)
    }
}
