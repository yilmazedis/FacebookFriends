//
//  SigninPresenter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SigninPresenterProtocol: AnyObject {
    var view: SigninViewProtocol? { get set }
    
    func dataFetched(data: [Person])
}

final class SigninPresenter: SigninPresenterProtocol {
    weak var view: SigninViewProtocol?

    func dataFetched(data: [Person]) {
        view?.updateData(data: data)
    }
}
