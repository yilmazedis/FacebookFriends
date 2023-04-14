//
//  SignupPresenter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    var view: SignupViewProtocol? { get set }
    
    func signUp(status isOn: Status)
}

final class SignupPresenter: SignupPresenterProtocol {
    weak var view: SignupViewProtocol?

    func signUp(status isOn: Status) {
        view?.signUp(status: isOn)
    }
}
