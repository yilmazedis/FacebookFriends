//
//  SigninRouter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

protocol SigninRouterProtocol: AnyObject {
    var entry: SigninEntryPoint? { get }
    
    static func start() -> SigninRouterProtocol
    func routeSignup()
    func routeFriendList()
}

final class SigninRouter: SigninRouterProtocol {
    var entry: SigninEntryPoint?
    
    static func start() -> SigninRouterProtocol {
        let router = SigninRouter()
        
        let interactor = SigninInteractor()
        let presenter = SigninPresenter()
        let viewController = SigninViewConroller()
        viewController.router = router
        
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController as SigninEntryPoint
        
        return router
    }
    
    func routeSignup() {
        guard let vc = SignupRouter.start().entry else { return }
        vc.modalPresentationStyle = .fullScreen
        
        entry?.show(vc, sender: self)
    }
    
    func routeFriendList() {
        guard let vc = FriendListRouter.start().entry else { return }
        vc.modalPresentationStyle = .fullScreen
        entry?.show(vc, sender: self)
    }
}
