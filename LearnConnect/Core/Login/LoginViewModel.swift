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
    
    func loginTapped(completion: (String) -> Void) {
        let user: User? = DatabaseManager.shared.getUsers().first { $0.email == email && $0.password == password }
        
        if let user = user,
           let id = user.id {
            completion(id)
        } else {
            activeAlert = .loginFailed
            showAlert.toggle()
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
