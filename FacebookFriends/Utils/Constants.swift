//
//  Constants.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

struct K {
    struct TMDB {
        static let url = "https://api.themoviedb.org/3/"
        static let movieCategory = "discover/movie"
        static let listCategory = "genre/movie/list"
        static let token = "3bb3e67969473d0cb4a48a0dd61af747"
        static let posterUrl = "https://image.tmdb.org/t/p/w200/"
        static let title = "Movies"
        static let videoURL = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
    }
    
    struct Person {
        static let cell = "FriendListCell"
    }
    
    struct Cache {
        static let name = "PersonCache"
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
        static let fromURL = "Got From URL"
    }
}
