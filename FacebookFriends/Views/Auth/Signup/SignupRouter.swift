//
//  SignupRouter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SignupRouterProtocol: AnyObject {
    var entry: SignupEntryPoint? { get }
    
    static func start() -> SignupRouterProtocol
    func routeSignin()
}

final class SignupRouter: SignupRouterProtocol {
    var entry: SignupEntryPoint?
    
    static func start() -> SignupRouterProtocol {
        let router = SignupRouter()
        
        let interactor = SignupInteractor()
        let presenter = SignupPresenter()
        let viewController = SignupViewController()
        viewController.router = router
        
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController as SignupEntryPoint
        
        return router
    }
    
    func routeSignin() {
        let vc = SigninViewConroller()
        vc.modalPresentationStyle = .fullScreen
        entry?.show(vc, sender: self)
    }
}
