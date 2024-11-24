//
//  LoginViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var activeAlert: LoginAlert = .loginFailed
    @Published var showAlert = false
    @Published var showActivity = false
    
    func loginTapped(completion: @escaping () -> Void) {
        showActivity = true
        AuthManager.shared.login(email: email, password: password) { [weak self] results in
            guard let self else { return }
            self.showActivity = false
            switch results {
            case .success(let currentUser):
                if let user = currentUser {
                    DatabaseManager.shared.addCurrentUser(id: user.id, name: user.name, email: user.email)
                    completion()
                }
            case .failure(_):
                activeAlert = .loginFailed
                showAlert.toggle()
            }
        }
    }
}

//MARK: - Login Alerts
enum LoginAlert {
    case loginFailed
    
    var title: String {
        switch self {
        case .loginFailed:
            "Login Failed"
        }
    }
    
    var message: String {
        switch self {
        case .loginFailed:
            "Invalid credentials"
        }
    }
}
