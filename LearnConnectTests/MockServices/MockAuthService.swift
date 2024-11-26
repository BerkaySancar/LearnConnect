//
//  MockAuthService.swift
//  LearnConnectTests
//
//  Created by Berkay Sancar on 26.11.2024.
//

@testable import LearnConnect

final class MockAuthService: AuthServiceProtocol {
    var shouldReturnError = true
    var mockUser: CurrentUser?
    
    var invokedLogin = false
    var invokedLoginCount = 0
    var invokedLoginParamsList = [(email: String, password: String)]()
    func login(email: String, password: String, completion: @escaping (Result<(CurrentUser)?, AuthError>) -> Void) {
        invokedLogin = true
        invokedLoginCount += 1
        invokedLoginParamsList.append((email, password))
        completion(.success(nil))
    }
    
    var invokedSignUp = false
    var invokedSignUpCount = 0
    var invokedSignUpParamsList = [(email: String, password: String)]()
    func signUp(name: String, email: String, password: String, completion: @escaping (Result<Void, LearnConnect.AuthError>) -> Void) {
        invokedSignUp = true
        invokedSignUpCount += 1
        invokedSignUpParamsList.append((email, password))
        completion(.success(()))
    }
    
    func signOut(completion: (Result<Void, LearnConnect.AuthError>) -> Void) {
        
    }
    
    func deleteAccount() {
        
    }
}
