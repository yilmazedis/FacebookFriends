//
//  FriendListConfigurator.swift
//  FacebookFriends
//
//  Created by yilmaz on 13.04.2023.
//

final class FriendListConfigurator {
    
    static let shared = FriendListConfigurator()
    
    func configure() -> FriendListViewConroller {
        
        let router = FriendListRouter()
        
        let interactor = FriendListInteractor()
        let presenter = FriendListPresenter()
        let viewController = FriendListViewConroller()
        viewController.router = router
        
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController as FriendListEntryPoint
                        
        return viewController
    }
}
