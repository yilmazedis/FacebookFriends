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

extension String {
    func toReadableDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        let readableDateFormatter = DateFormatter()
        readableDateFormatter.dateStyle = .medium
        readableDateFormatter.timeStyle = .medium
        return readableDateFormatter.string(from: date)
    }
}
