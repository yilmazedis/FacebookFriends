//
//  IconLabel.swift
//  FacebookFriends
//
//  Created by yilmaz on 14.04.2023.
//

import UIKit

class IconLabel: UILabel {
    enum IconPosition {
        case left, right
    }
    
    var icon: UIImage?
    var iconPosition: IconPosition = .left
    
    override func drawText(in rect: CGRect) {
        // Get the icon size
        var iconSize: CGSize = .zero
        if let icon = icon {
            iconSize = icon.size
        }
        
        // Calculate the label text size
        let textRect = rect.inset(by: UIEdgeInsets(top: 0, left: iconSize.width, bottom: 0, right: iconSize.width))
        super.drawText(in: textRect)
        
        // Draw the icon
        if let icon = icon {
            let iconRect = CGRect(x: iconPosition == .left ? rect.origin.x : rect.maxX - iconSize.width,
                                  y: (rect.height - iconSize.height) / 2,
                                  width: iconSize.width,
                                  height: iconSize.height)
            icon.draw(in: iconRect)
        }
    }
}

