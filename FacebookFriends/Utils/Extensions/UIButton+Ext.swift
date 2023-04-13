//
//  UIButton+Ext.swift
//  FacebookFriends
//
//  Created by yilmaz on 13.04.2023.
//

import UIKit

extension UIButton {
    private func setDefaultButton(buttonName: String) {
        self.setTitle(buttonName, for: .normal)
        self.setTitleColor(UIColor.purple(), for: .normal)
        self.layer.cornerRadius = 15
    }
    
    func setDefaultClearButton(buttonName: String, fontSize: CGFloat) {
        setDefaultButton(buttonName: buttonName)
        self.titleLabel!.font = UIFont.appMainBold(fontSize: fontSize)
        self.backgroundColor = .clear
    }
    
    func setDefaultAppButton(buttonName: String, fontSize: CGFloat) {
        setDefaultButton(buttonName: buttonName)
        self.titleLabel!.font = UIFont.appMainBold(fontSize: fontSize)
        self.backgroundColor = UIColor.blue()
    }
}
