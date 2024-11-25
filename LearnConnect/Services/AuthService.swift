//
//  AuthService.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

import FirebaseAuth
import FirebaseCore

protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<(CurrentUser)?, AuthError>) -> Void)
    func signUp(name: String, email: String, password: String, completion: @escaping (Result<Void, AuthError>) -> Void)
    func signOut(completion: (Result<Void, AuthError>) -> Void)
    func deleteAccount()
}

final class AuthService: AuthServiceProtocol {
    
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    
    private init() { }
    
    func login(email: String, password: String, completion: @escaping (Result<(CurrentUser)?, AuthError>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error)  in
            if let result,
               let displayName = result.user.displayName,
               let email = result.user.email {
                completion(.success((CurrentUser(id: result.user.uid, name: displayName, email: email))))
            }
            if let error {
                print(error.localizedDescription)
                completion(.failure(.loginError))
            }
        }
    }
    
    func signUp(name: String, email: String, password: String, completion: @escaping (Result<Void, AuthError>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error)
                completion(.failure(.signUpError))
            } else if let user = result?.user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("Profile updating failed. \(error.localizedDescription)")
                        completion(.failure(.signUpError))
                    } else {
                        completion(.success(()))
                    }
                }
            } else {
                completion(.failure(.signUpError))
            }
        }
    }

    func signOut(completion: (Result<Void, AuthError>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(.signOutError))
        }
    }
    
    func deleteAccount() {
        let user = auth.currentUser
        
        user?.delete { error in
            if let error {
                print("Account deletion failed. \(error.localizedDescription)")
            }
        }
    }
}

//MARK: -
enum AuthError: Error {
    case loginError
    case signUpError
    case signOutError
    
    var errorDescription: String {
        switch self {
        case .loginError:
            return "Login failed. Try again."
        case .signUpError:
            return "Something went wrong. Try again."
        case .signOutError:
            return "Sign out failed. Try again."
        }
    }
}
