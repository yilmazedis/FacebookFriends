//
//  UIImageView+Ext.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

extension UIImageView {
    func networkImage(with downloader: ImageDownloader = ImageDownloader(),
                      expiryDate: Date = Date().addingTimeInterval(TimeInterval(K.Cache.expiryDate)),
                      url: URL) {
        downloader.downloadPhoto(with: url,  expiryDate: expiryDate, completion: { (image, isCached) in
            if isCached {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                UIView.transition(with: self, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }, completion: nil)
            }
        })
    }
}
