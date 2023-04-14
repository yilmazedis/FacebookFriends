//
//  FriendListDataSource.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

protocol FriendListDataSourceDelegate: AnyObject {
    func fetchData()
    func selectPerson(with movie: Person)
}

final class FriendListDataSource: UICollectionViewFlowLayout {
    
    weak var delegate: FriendListDataSourceDelegate?
    
    var person: [Person] = []
    
    let itemsPerRow = 3
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 0, right: 10.0)
    private var isLoading: Bool = false
    
    override init() {
        super.init()
        scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError(K.ErrorMessage.requiredInit)
    }
    
//    // You can use others, up to you, Optional approach, up to you
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        // Check if the user has scrolled to the bottom of the collection view
//        let contentHeight = scrollView.contentSize.height
//        let yOffset = scrollView.contentOffset.y
//        let height = scrollView.frame.height
//        if yOffset + height > contentHeight - 400 {
//            // Increment the page number and make another network call to fetch the data
//            delegate?.fetchData()
//            //FastLogger.log(what: K.InfoMessage.paginationLength, about: .info)
//        }
//    }
}

extension FriendListDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem + 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension FriendListDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        person.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Person.cell, for: indexPath) as? FriendListCell else { return UICollectionViewCell() }
        
        cell.configure(model: person[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectPerson(with: person[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if indexPath.item == person.count - 15 { //it's your last cell
             delegate?.fetchData()
         }
    }
}
