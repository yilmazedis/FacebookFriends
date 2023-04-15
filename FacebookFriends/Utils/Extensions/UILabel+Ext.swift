//
//  UILabel+Ext.swift
//  FacebookFriends
//
//  Created by yilmaz on 14.04.2023.
//

import UIKit

extension UILabel {
    
    func addTrailing(image: UIImage, text: String?) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let attributedString = NSMutableAttributedString(string: text +  " ")
        attributedString.append(attachmentString)

        self.attributedText = attributedString
    }
    
    func addLeading(image: UIImage, text: String?) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let attributedString = NSMutableAttributedString(attributedString: attachmentString)
        attributedString.append(NSAttributedString(string: " " + text))

        self.attributedText = attributedString
    }
}
