//
//  ViewController.swift
//  FacebookFriends
//
//  Created by yilmaz on 11.04.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var usernameTextField: UITextField = {
        let view = UITextField()
        //view.icon = .add
        
        var imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 20, height: 20))
        var image = UIImage(systemName: "person.fill")
        imageView.image = image

        view.leftPadding = 10
        view.leftImage = UIImage(systemName: "person.fill")
     
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        //usernameTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
    }


}
