//
//  SignupInteractor.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

protocol SignupInteractorProtocol {
    var presenter: SignupPresenterProtocol? { get set }
    
    func fetchData(page: Int)
}

final class SignupInteractor: SignupInteractorProtocol {
    var presenter: SignupPresenterProtocol?
    
    func fetchData(page: Int) {
        
        let queries = [
            "api_key": K.TMDB.token,
            "sort_by": "popularity.desc",
            "include_adult": "false",
            "include_video": "false",
            "language": "en-US",
            "page": String(page),
        ]
        
        let urlStr = K.TMDB.url + K.TMDB.movieCategory
        let url = urlStr.composeURL(queries: queries)
        
        NetworkManager.shared.fetch(with: url) { [weak self] (result: Result<People, Error>) in
            
            switch result {
            case .success(let movies):
                self?.presenter?.dataFetched(data: movies.results)
                
            case .failure(let error):
                FastLogger.log(what: "Fetching Movies Failure", over: error)
            }
        }
    }
}
