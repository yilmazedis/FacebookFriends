//
//  UIViewController+Ext.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

extension UIViewController {
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgoundColor

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.title = title

        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgoundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
}

extension UIViewController {
    func showActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = 100 // Set a tag value to easily retrieve the activity indicator later
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            // view.isUserInteractionEnabled = false // Disable user interaction while the activity indicator is showing
        }
        
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let activityIndicator = self.view.viewWithTag(100) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                // self.view.isUserInteractionEnabled = true // Enable user interaction once the activity indicator is hidden
            }
        }
    }
}
