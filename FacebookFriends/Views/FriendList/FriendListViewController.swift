//
//  FriendListViewController.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

typealias FriendListEntryPoint = FriendListViewProtocol & UIViewController

protocol FriendListViewProtocol: AnyObject {
    var interactor: FriendListInteractorProtocol? { get set }
    var router: FriendListRouterProtocol? { get set }
    
    func updateData(data: [Person])
}

final class FriendListViewConroller: UIViewController {
    // MARK: - InteractorProtocol
    var interactor: FriendListInteractorProtocol?
    weak var router: FriendListRouterProtocol?
    
    // MARK: - Private
    private let movieDataSource = FriendListDataSource()

    // MARK: - Private Lazy
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(FriendListCell.self, forCellWithReuseIdentifier: K.Person.cell)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchData(page: 1)
        
        collectionView.delegate = movieDataSource
        collectionView.dataSource = movieDataSource
        collectionView.collectionViewLayout = movieDataSource
        movieDataSource.delegate = self
        
        setCollectionViewLayout()
    }
    
    private func setCollectionViewLayout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension FriendListViewConroller: FriendListViewProtocol {
    func updateData(data: [Person]) {

    }
}

extension FriendListViewConroller: FriendListDataSourceDelegate {
    func fetchData(page: Int) {
        interactor?.fetchData(page: page)
    }
    
    func selectedMovie(with person: Person) {
        router?.showMovieDetailViewController(person: person)
    }
}
