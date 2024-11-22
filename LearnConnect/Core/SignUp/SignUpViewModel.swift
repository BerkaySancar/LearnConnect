//
//  SignUpViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    @Published var showAlert = false
    @Published var activeAlert: SignUpAlert = .signUpFailure
    
    func signUpTapped() {
        if firstName == "" || lastName == "" || email == "" || password == "" || password.count < 5 || !email.isValidEmail() {
            activeAlert = .signUpFailure
            showAlert.toggle()
        } else {
            DatabaseManager.shared.addUser(name: firstName, surname: lastName, email: email, password: password)
            activeAlert = .signUpSuccess
            showAlert.toggle()
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
