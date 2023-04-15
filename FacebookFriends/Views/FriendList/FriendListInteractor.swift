//
//  FriendListInteractor.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//


import RealmSwift
import Foundation

protocol FriendListInteractorProtocol {
    var presenter: FriendListPresenterProtocol? { get set }
    
    func fetchData()
    func resetCurrentPage()
}

final class FriendListInteractor: FriendListInteractorProtocol {
    var presenter: FriendListPresenterProtocol?
    private let expiryDate: Date
    private var currentPage = 1
    
    init(expiryDate: Date) {
        self.expiryDate = expiryDate
    }
    
    func fetchData() {
        guard let url = URL(string: K.Person.url + "?results=30&seed=abc&page=" + String(currentPage)) else { return }
        currentPage += 1
        NetworkManager.shared.fetch(with: url, expiryDate: expiryDate) { [weak self] (result: Result<People, Error>) in
            
            switch result {
            case .success(let people):
                self?.presenter?.dataFetched(data: people.results)
                
            case .failure(let error):
                FastLogger.log(what: "Fetching People Failure", over: error)
            }
        }
    }
    
    func resetCurrentPage() {
        currentPage = 1
    }
}
