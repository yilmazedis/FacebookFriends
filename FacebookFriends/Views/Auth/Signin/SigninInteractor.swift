//
//  SigninInteractor.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SigninInteractorProtocol {
    var presenter: SigninPresenterProtocol? { get set }
    
    func fetchData(page: Int)
}

final class SigninInteractor: SigninInteractorProtocol {
    var presenter: SigninPresenterProtocol?
    
    func fetchData(page: Int) {
        
    }
}
