//
//  SignupRouter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

protocol SignupRouterProtocol: AnyObject {
    var entry: SignupEntryPoint? { get }
    
    func routeSignin()
    func routeFriendList()
}

final class SignupRouter: SignupRouterProtocol {
    weak var entry: SignupEntryPoint?

    func routeSignin() {
        entry?.dismiss(animated: true)
    }
    
    func routeFriendList() {
        let vc = UINavigationController(rootViewController: FriendListConfigurator.shared.configure())
        
        vc.modalPresentationStyle = .fullScreen

        entry?.show(vc, sender: self)
    }
}
