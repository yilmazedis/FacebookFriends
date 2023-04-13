//
//  FriendListCell.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

final class FriendListCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
       let view = UIImageView()
        return view
    }()
    
    private lazy var friendName: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 14, weight: .medium)
        return view
    }()
    
    private var imageDownloader = ImageDownloader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLayout()
    }
    
    private func setLayout() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        
        contentView.addSubview(friendName)
        friendName.translatesAutoresizingMaskIntoConstraints = false
        friendName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        friendName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        friendName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    override func prepareForReuse() {
        imageView.backgroundColor = .clear
        imageView.image = nil
        imageDownloader.cancel()
    }

    func configure(model: Person) {
        
        friendName.text = model.name.first
                
        guard let url = URL(string: model.picture.thumbnail) else { return }
        
        imageView.networkImage(with: imageDownloader, url: url)
    }
}
