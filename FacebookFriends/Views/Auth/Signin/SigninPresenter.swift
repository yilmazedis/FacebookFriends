//
//  SigninPresenter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SigninPresenterProtocol: AnyObject {
    var view: SigninViewProtocol? { get set }
    
    func signin(status isOn: UserValidationError)
    func signin()
}

final class SigninPresenter: SigninPresenterProtocol {
    weak var view: SigninViewProtocol?

    func signin(status isOn: UserValidationError) {
        
        var errorMessage: String
        
        switch isOn {
        case .invalidEmail:
            errorMessage = "Invalid email"
        case .invalidPassword:
            errorMessage = "Password must be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, and one digit"
        case .wrongPassword:
            errorMessage = "Wrong Password"
        case .invalidFullName:
            errorMessage = "Full name must be at least two words separated by a space"
        case .invalidUsername:
            errorMessage = "Username must be at least 3 characters long and contain only alphanumeric characters or underscores"
        case .invalidMatchingPasswords:
            errorMessage = "Password are not matching"
        case .userAlreadyExists:
            errorMessage = "User already exists"
        case .userNotFound:
            errorMessage = "User is not found"
        case .any:
            errorMessage = "Undefined Error"
        }
        
        view?.signin(errorMessage: errorMessage)
    }
    
    func signin() {
        view?.signin()
    }
}
