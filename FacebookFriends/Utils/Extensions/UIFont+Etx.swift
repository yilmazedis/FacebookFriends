//
//  UIFont.swift
//  FacebookFriends
//
//  Created by yilmaz on 15.04.2023.
//

import UIKit

extension UIFont {
    static func appMainRegular(fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    static func appMainBold(fontSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: fontSize)
    }
}
