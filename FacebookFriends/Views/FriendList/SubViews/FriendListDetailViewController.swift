//
//  FriendListDetailViewController.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

final class FriendListDetailViewController: UIViewController {
    
    // MARK: - Views
    private lazy var imageView: UIImageView = {
       let view = UIImageView()
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var movieOverview: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.textAlignment = .natural
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var movieReleaseDate: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .regular)
        view.textAlignment = .left
        view.textColor = .label
        return view
    }()
    
    // MARK: - Privates
    private var person: Person
    
    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(K.ErrorMessage.requiredInit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
                
        configureNavigationBar(largeTitleColor: .label,
                               backgoundColor: .systemBlue,
                               tintColor: .label,
                               title: person.name?.first ?? "",
                               preferredLargeTitle: false)
        
        setImageAutolayout()
        setAutolayout()
        setContents()
    }
    
    private func setContents() {
        
        movieOverview.text = person.gender
    }
    
    private func setImageAutolayout() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    private func setAutolayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        contentView.addSubview(movieReleaseDate)
        movieReleaseDate.translatesAutoresizingMaskIntoConstraints = false
        movieReleaseDate.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieReleaseDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        movieReleaseDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        movieReleaseDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        contentView.addSubview(movieOverview)
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        movieOverview.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieOverview.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor, constant: 25).isActive = true
        movieOverview.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 15/16).isActive = true
        movieOverview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
