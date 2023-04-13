//
//  FriendListPresenter.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol FriendListPresenterProtocol: AnyObject {
    var view: FriendListViewProtocol? { get set }
    
    func dataFetched(data: [Person])
}

final class FriendListPresenter: FriendListPresenterProtocol {
    weak var view: FriendListViewProtocol?

    func dataFetched(data: [Person]) {
        view?.updateData(data: data)
    }
}
