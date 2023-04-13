//
//  OperatorOverloads.swift
//  FacebookFriends
//
//  Created by yilmaz on 13.04.2023.
//

func +(lhs: String?, rhs: String?) -> String {
    return lhs?.appending(rhs ?? "") ?? ""
}
