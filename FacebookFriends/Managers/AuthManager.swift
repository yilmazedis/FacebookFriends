//
//  AuthManager.swift
//  FacebookFriends
//
//  Created by yilmaz on 14.04.2023.
//

import RealmSwift

class UserAuthData: Object {
    @objc dynamic var username: String?
    @objc dynamic var fullName: String?
    @objc dynamic var email: String?
    @objc dynamic var password: String?
    
    override static func primaryKey() -> String? {
        return "email"
    }
}

class UserAuthManager {
    
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func signUp(email: String, password: String, username: String, fullName: String) throws {
        guard realm.object(ofType: UserAuthData.self, forPrimaryKey: email) == nil else {
            throw UserAuthError.userAlreadyExists
        }
        
        let authData = UserAuthData()
        authData.email = email
        authData.password = password
        authData.username = username
        authData.fullName = fullName
        
        try realm.write {
            realm.add(authData)
        }
    }
    
    func signIn(email: String, password: String) throws {
        guard let authData = realm.object(ofType: UserAuthData.self, forPrimaryKey: email) else {
            throw UserAuthError.userNotFound
        }
        
        guard authData.password == password else {
            throw UserAuthError.invalidPassword
        }
        
        // Successfully authenticated, do something here
    }
    
}
