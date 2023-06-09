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
    var router: FriendListRouterProtocol?
    
    // MARK: - Private
    private let dataSource = FriendListDataSource()
    private let mutex = Mutex()
    private let refreshControl = UIRefreshControl()

    // MARK: - Private Lazy
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(FriendListCell.self, forCellWithReuseIdentifier: K.Person.cell)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = dataSource
        dataSource.delegate = self
        
        setCollectionViewLayout()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemBlue, tintColor: .white, title: "Friend List", preferredLargeTitle: false)
        
        let signoutButton = UIBarButtonItem(title: "Signout", style: .plain, target: self, action: #selector(signoutButtonAction))
        navigationItem.rightBarButtonItem = signoutButton
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(_:)), for: .valueChanged)
        
        showActivityIndicator()
        interactor?.fetchData()
    }
    
    private func setCollectionViewLayout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc func refreshCollectionView(_ sender: UIRefreshControl) {
        // Perform data refresh
        CacheManager.shared.clearCache()
        dataSource.person.removeAll()
        collectionView.reloadData()
        interactor?.resetCurrentPage()
        interactor?.fetchData()
        
        // End refreshing
        sender.endRefreshing()
    }
    
    @objc private func signoutButtonAction() {
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension FriendListViewConroller: FriendListViewProtocol {
    func updateData(data: [Person]) {
        hideActivityIndicator()
        DispatchQueue.main.async { [weak self] in
            // If fetch calls so twice or trice while scrolling
            // We must secure critical section
            self?.mutex.sync {
                let newItems = data
                // Calculate the index paths of the new items based on the current count
                guard let startIndex = self?.collectionView.numberOfItems(inSection: 0) else { return }
                let endIndex = startIndex + newItems.count - 1
                let indexPaths = (startIndex...endIndex).map { IndexPath(item: $0, section: 0) }

                self?.dataSource.person.append(contentsOf: data)
                // Insert the new items to the collection view
                self?.collectionView.performBatchUpdates({
                    self?.collectionView.insertItems(at: indexPaths)
                }, completion: nil)
            }
        }
    }
}

extension FriendListViewConroller: FriendListDataSourceDelegate {
    func fetchData() {
        showActivityIndicator()
        interactor?.fetchData()
    }
    
    func selectPerson(with person: Person) {
        hideActivityIndicator()
        router?.showMovieDetailViewController(person: person)
    }
}
