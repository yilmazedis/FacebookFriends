//
//  SignupPresenter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    var view: SignupViewProtocol? { get set }
    
    func dataFetched(data: [Person])
}

final class SignupPresenter: SignupPresenterProtocol {
    weak var view: SignupViewProtocol?

    func dataFetched(data: [Person]) {
        view?.updateData(data: data)
    }
}
