//
//  SigninRouter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

protocol SigninRouterProtocol: AnyObject {
    var entry: SigninEntryPoint? { get }
    
    func routeSignup()
    func routeFriendList()
}

final class SigninRouter: SigninRouterProtocol {
    weak var entry: SigninEntryPoint?
    
    func routeSignup() {
       
        let vc = SignupConfigurator.shared.configure()
        
        vc.modalPresentationStyle = .fullScreen

        entry?.show(vc, sender: self)
    }
    
    func routeFriendList() {
        let vc = UINavigationController(rootViewController: FriendListConfigurator.shared.configure())  
        
        vc.modalPresentationStyle = .fullScreen

        entry?.show(vc, sender: self)
    }
}
