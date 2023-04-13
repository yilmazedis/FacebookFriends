//
//  FriendListInteractor.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//


import Foundation

protocol FriendListInteractorProtocol {
    var presenter: FriendListPresenterProtocol? { get set }
    
    func fetchData(page: Int)
}

final class FriendListInteractor: FriendListInteractorProtocol {
    var presenter: FriendListPresenterProtocol?
    
    func fetchData(page: Int) {
                
        let queries = [
            "page": String(page),
            "results": "30",
            "seed": "abc"
        ]
        
        let urlStr = K.Person.url
        let url = urlStr.composeURL(queries: queries)
        
        NetworkManager.shared.fetch(with: url) { [weak self] (result: Result<People, Error>) in
            
            switch result {
            case .success(let people):
                self?.presenter?.dataFetched(data: people.results)
                
            case .failure(let error):
                FastLogger.log(what: "Fetching People Failure", over: error)
            }
        }
    }
}
