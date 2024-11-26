//
//  SettingsViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    private let authService: AuthServiceProtocol
    private let currentUserService: CurrentUserService
    
    init(authService: AuthService = AuthService(),
         currentUserService: CurrentUserService = .shared) {
        self.authService = authService
        self.currentUserService = currentUserService
    }
    
    func signOutTapped() {
        authService.signOut { results in
            switch results {
            case .success(_):
                currentUserService.deleteCurrentUser()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func deleteAccountBy() {
        authService.deleteAccount()
        currentUserService.deleteCurrentUser()
    }
}
