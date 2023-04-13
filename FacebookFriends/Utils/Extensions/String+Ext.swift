//
//  String+Ext.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

extension String {
    func composeURL(queries: [String: String]) -> URL? {
        guard let componentsUrl = URL.init(string: self),
              var components = URLComponents.init(url: componentsUrl, resolvingAgainstBaseURL: false) else {
            FastLogger.log(what: K.ErrorMessage.url, about: .error)
            return nil
        }
        
        let queryItems = queries.map({URLQueryItem.init(name: $0.key, value: $0.value)})
        
        components.queryItems = queryItems
        return components.url
    }
}
