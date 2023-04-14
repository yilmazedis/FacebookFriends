//
//  Constants.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

struct K {
    struct Person {
        static let cell = "FriendListCell"
        static let url = "https://randomuser.me/api/"
    }
    
    struct Cache {
        static let name = "PersonCache"
        static let expiryDate = 3600
    }
    
    struct ErrorMessage {
        static let model = "Model is nil"
        static let movieId = "PersonId is nil"
        static let cell = "Cell is nil"
        static let movies = "People is nil"
        static let requiredInit = "init(coder:) has not been implemented"
        static let url = "Fail to conver urlStr to url"
    }
    
    struct InfoMessage {
        static let paginationLength = "Pagination length is equal to fetched data length"
        static let refreshPage = "Refresh page"
        static let api = "Fetching data is successed"
        static let noGenre = "There are no Genre"
    }
    
    struct DebugMessage {
        static let fromCache = "Got From Cache"
        static let expiryDate = "Time Expired & Gonna Get From URL"
        static let fromURL = "Got From URL"
    }
}
