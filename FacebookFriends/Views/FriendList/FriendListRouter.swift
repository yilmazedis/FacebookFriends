//
//  FriendListRouter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

protocol FriendListRouterProtocol: AnyObject {
    var entry: FriendListEntryPoint? { get }
    
    static func start() -> FriendListRouterProtocol
    func showMovieDetailViewController(person: Person)
}

final class FriendListRouter: FriendListRouterProtocol {
    var entry: FriendListEntryPoint?
    
    static func start() -> FriendListRouterProtocol {
        let router = FriendListRouter()
        
        let interactor = FriendListInteractor()
        let presenter = FriendListPresenter()
        let viewController = FriendListViewConroller()
        viewController.router = router
        
        presenter.view = viewController
        viewController.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = viewController as FriendListEntryPoint
        
        return router
    }
    
    func showMovieDetailViewController(person: Person) {
        let vc = FriendListDetailViewController(person: person)
        
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        
        entry?.show(navVc, sender: self)
    }
}
