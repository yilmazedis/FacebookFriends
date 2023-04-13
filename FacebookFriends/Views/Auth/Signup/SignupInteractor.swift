//
//  SignupInteractor.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SignupInteractorProtocol {
    var presenter: SignupPresenterProtocol? { get set }
    
    func fetchData(page: Int)
}

final class SignupInteractor: SignupInteractorProtocol {
    var presenter: SignupPresenterProtocol?
    
    func fetchData(page: Int) {
        
    }
}
