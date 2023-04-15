//
//  SignupInteractor.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SignupInteractorProtocol {
    var presenter: SignupPresenterProtocol? { get set }
    
    func validateAndSignup(email: String, password: String, repassword: String, fullName: String, username: String)
}

final class SignupInteractor: SignupInteractorProtocol {
    var presenter: SignupPresenterProtocol?
    
    let authManager: UserAuthManager
    
    init(authManager: UserAuthManager) {
        self.authManager = authManager
    }
    
    func validateAndSignup(email: String, password: String, repassword: String, fullName: String, username: String) {
        do {
            try UserValidation.shared.checkFull(email: email, password: password, repassword: repassword, fullName: fullName, username: username)
            signup(email: email, password: password, username: username, fullName: fullName)
        } catch let error {
            finalDecision(error: error)
        }
    }
    
    private func signup(email: String, password: String, username: String, fullName: String) {
        do {
            try authManager.signup(email: email, password: password, username: username, fullName: fullName)
            presenter?.signup()
        } catch let error {
            finalDecision(error: error)
        }
    }
    
    private func finalDecision(error: Error) {
        if let authError = error as? UserValidationError {
            presenter?.signup(status: authError)
        } else {
            presenter?.signup(status: .any)
        }
    }
}
