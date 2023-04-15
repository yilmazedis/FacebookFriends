//
//  FriendListConfigurator.swift
//  FacebookFriends
//
//  Created by yilmaz on 13.04.2023.
//

import Foundation

final class FriendListConfigurator {
    
    static let shared = FriendListConfigurator()
    
    func configure() -> FriendListViewConroller {
        
        let expiryDate = Date().addingTimeInterval(TimeInterval(K.Cache.expiryDate))
        
        let router = FriendListRouter()
        let interactor = FriendListInteractor(expiryDate: expiryDate)
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
