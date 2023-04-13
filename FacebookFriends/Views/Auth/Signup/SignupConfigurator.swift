//
//  SignupConfigurator.swift
//  FacebookFriends
//
//  Created by yilmaz on 13.04.2023.
//

final class SignupConfigurator {
    
    static let shared = SignupConfigurator()
    
    func configure() -> SignupViewController {
        let router = SignupRouter()
        
        let interactor = SignupInteractor()
        let presenter = SignupPresenter()
        let viewController = SignupViewController()
        viewController.router = router
        
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController as SignupEntryPoint
                        
        return viewController
    }
}
