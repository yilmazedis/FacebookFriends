//
//  SignupInteractor.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SignupInteractorProtocol {
    var presenter: SignupPresenterProtocol? { get set }
    
    func signup(email: String, password: String, username: String, fullName: String)
}

final class SignupInteractor: SignupInteractorProtocol {
    var presenter: SignupPresenterProtocol?
    
    let authManager: UserAuthManager
    
    init(authManager: UserAuthManager) {
        self.authManager = authManager
    }
    
    func signup(email: String, password: String, username: String, fullName: String) {
        do {
            try authManager.signUp(email: email, password: password, username: username, fullName: fullName)
            presenter?.signUp(status: .success)
        } catch {
            presenter?.signUp(status: .fail)
            print("Error signing up: \(error)")
        }
    }
}
