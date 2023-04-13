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

    // MARK: - Private Lazy
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(FriendListCell.self, forCellWithReuseIdentifier: K.Person.cell)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchData(page: 1)
        
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = dataSource
        dataSource.delegate = self
        
        setCollectionViewLayout()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .systemBlue, tintColor: .white, title: "Friend List", preferredLargeTitle: true)
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
    func fetchData(page: Int) {
        interactor?.fetchData(page: page)
    }
    
    func selectPerson(with person: Person) {
        router?.showMovieDetailViewController(person: person)
    }
}
