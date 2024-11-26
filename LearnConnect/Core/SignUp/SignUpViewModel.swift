//
//  SignUpViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    private let authService: AuthServiceProtocol
    
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var userName: String = ""
    
    @Published var showAlert = false
    @Published var activeAlert: SignUpAlert = .signUpFailure
    @Published var showActivity: Bool = false
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    func signUpTapped(email: String, password: String) {
        if userName == "" || email == "" || password == "" || password.count < 5 || !email.isValidEmail() {
            activeAlert = .signUpFailure
            showAlert.toggle()
        } else {
            self.showActivity.toggle()
            authService.signUp(name: userName, email: email, password: password) { [weak self] results in
                guard let self else { return }
                self.showActivity.toggle()
                switch results {
                case .success(_):
                    activeAlert = .signUpSuccess
                case .failure(_):
                    activeAlert = .signUpFailure
                }
                showAlert.toggle()
            }
        }
    }
}

//MARK: SignUp Alerts
enum SignUpAlert {
    case signUpSuccess
    case signUpFailure
    
    var title: String {
        switch self {
        case .signUpSuccess:
            "Register Successfull"
        case .signUpFailure:
            "Register Failure"
        }
    }
    
    var message: String {
        switch self {
        case .signUpSuccess:
            "Please login."
        case .signUpFailure:
            "Please enter a valid email. The password cannot be less than 5 characters, and make sure to fill in all the information completely."
        }
    }
}
