//
//  SignupRouter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SignupRouterProtocol: AnyObject {
    var entry: SignupEntryPoint? { get }
    
    func routeSignin()
}

final class SignupRouter: SignupRouterProtocol {
    weak var entry: SignupEntryPoint?

    func routeSignin() {
        entry?.dismiss(animated: true)
    }
}
