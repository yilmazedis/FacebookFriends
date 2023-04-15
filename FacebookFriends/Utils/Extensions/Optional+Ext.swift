//
//  Optional+Ext.swift
//  FacebookFriends
//
//  Created by yilmaz on 13.04.2023.
//

extension Optional where Wrapped == String {
    var value: String {
        self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var value: Int {
        self ?? 0
    }
}
