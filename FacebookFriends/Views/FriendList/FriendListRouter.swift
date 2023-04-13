//
//  FriendListRouter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

protocol FriendListRouterProtocol: AnyObject {
    var entry: FriendListEntryPoint? { get }
    
    func showMovieDetailViewController(person: Person)
}

final class FriendListRouter: FriendListRouterProtocol {
    weak var entry: FriendListEntryPoint?
    
    func showMovieDetailViewController(person: Person) {
        let vc = FriendListDetailViewController(person: person)
        
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        
        entry?.show(navVc, sender: self)
    }
}
