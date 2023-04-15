//
//  UserValidationError.swift
//  FacebookFriends
//
//  Created by yilmaz on 14.04.2023.
//

enum UserValidationError: Error {
    case invalidEmail
    case invalidPassword
    case wrongPassword
    case invalidFullName
    case invalidUsername
    case invalidMatchingPasswords
    
    case userAlreadyExists
    case userNotFound
    case any
}
