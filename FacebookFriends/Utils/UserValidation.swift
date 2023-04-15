//
//  UserValidation.swift
//  FacebookFriends
//
//  Created by yilmaz on 15.04.2023.
//

import Foundation

class UserValidation {
    
    static let shared = UserValidation()
    
    func checkFull(email: String, password: String, repassword: String, fullName: String, username: String) throws {
        guard isValidEmail(email) else {
            throw UserValidationError.invalidEmail
        }
        
        guard isValidPassword(password) else {
            throw UserValidationError.invalidPassword
        }
        
        guard isValidFullName(fullName) else {
            throw UserValidationError.invalidFullName
        }
        
        guard isValidUsername(username) else {
            throw UserValidationError.invalidUsername
        }

        guard isValidMatchingPasswords(password, repassword) else {
            throw UserValidationError.invalidMatchingPasswords
        }
    }
    
    func check(email: String, password: String) throws {
        guard isValidEmail(email) else {
            throw UserValidationError.invalidEmail
        }
        
        guard isValidPassword(password) else {
            throw UserValidationError.invalidPassword
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        // Password must be at least 6 characters long and contain at least one uppercase letter, one lowercase letter, and one digit
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    private func isValidFullName(_ fullName: String) -> Bool {
        // Full name must be at least two words separated by a space
        let fullNameComponents = fullName.components(separatedBy: " ")
        return fullNameComponents.count >= 2
    }

    private func isValidUsername(_ username: String) -> Bool {
        // Username must be at least 3 characters long and contain only alphanumeric characters or underscores
        let usernameRegex = "^[a-zA-Z0-9_]{3,}$"
        let usernamePredicate = NSPredicate(format:"SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)
    }
    
    private func isValidMatchingPasswords(_ password: String, _ repassword: String) -> Bool {
        password == repassword
    }
}
