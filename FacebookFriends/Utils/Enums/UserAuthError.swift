//
//  UserAuthError.swift
//  FacebookFriends
//
//  Created by yilmaz on 14.04.2023.
//

enum UserAuthError: Error {
    case userAlreadyExists
    case userNotFound
    case invalidPassword
}
