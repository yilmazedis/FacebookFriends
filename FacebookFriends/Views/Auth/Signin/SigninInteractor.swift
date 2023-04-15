//
//  SigninInteractor.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SigninInteractorProtocol {
    var presenter: SigninPresenterProtocol? { get set }
    
    func validateAndSignin(email: String, password: String)
}

final class SigninInteractor: SigninInteractorProtocol {
    var presenter: SigninPresenterProtocol?
    
    let authManager: UserAuthManager
    
    init(authManager: UserAuthManager) {
        self.authManager = authManager
    }
    
    func validateAndSignin(email: String, password: String) {
        do {
            try UserValidation.shared.check(email: email, password: password)
            signin(email: email, password: password)
        } catch {
            finalDecision(error: error)
        }
    }
    
    private func signin(email: String, password: String) {
        do {
            try authManager.signin(email: email, password: password)
            presenter?.signin()
        } catch {
            finalDecision(error: error)
        }
    }
    
    private func finalDecision(error: Error) {
        if let userError = error as? UserValidationError {
            presenter?.signin(status: userError)
        } else {
            presenter?.signin(status: .any)
        }
    }
}
