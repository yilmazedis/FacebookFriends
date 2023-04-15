//
//  LoginConfigurator.swift
//  FacebookFriends
//
//  Created by yilmaz on 13.04.2023.
//

final class SigninConfigurator {
    
    static let shared = SigninConfigurator()
    
    func configure() -> SigninViewController {
        
        let router = SigninRouter()
        
        let authManager = UserAuthManager()
        
        let interactor = SigninInteractor(authManager: authManager)
        let presenter = SigninPresenter()
        let viewController = SigninViewController()
        viewController.router = router
        
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController as SigninEntryPoint
                
        return viewController
    }
}
