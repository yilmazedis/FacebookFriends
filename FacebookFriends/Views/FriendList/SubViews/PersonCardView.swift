//
//  PersonCardView.swift
//  FacebookFriends
//
//  Created by yilmaz on 13.04.2023.
//

import UIKit

final class PersonCardView: UIView {
    
    private let genderLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    private let ageLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    private let phoneNumberLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    private let emailLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    private let locationLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    private let timezoneLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .right
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    private let createdTimeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .right
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    private let idLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .right
        view.textColor = .label
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    // MARK: - Public methods
    
    func configure(model: Person) {
        genderLabel.addLeading(image: UIImage(systemName: "person.crop.circle.badge.questionmark")!, text: model.gender)
        ageLabel.addLeading(image: UIImage(systemName: "calendar")!, text: model.dob?.age?.description)
        phoneNumberLabel.addLeading(image: UIImage(systemName: "phone")!, text: model.phone)
        emailLabel.addLeading(image: UIImage(systemName: "mail")!, text: model.email)
        locationLabel.addLeading(image: UIImage(systemName: "location")!, text: model.location?.city)
        timezoneLabel.addLeading(image: UIImage(systemName: "clock.arrow.2.circlepath")!, text: model.location?.timezone?.offset)
        
        usernameLabel.addTrailing(image:  UIImage(systemName: "person.circle")!, text:  model.login?.username)
        createdTimeLabel.addTrailing(image:  UIImage(systemName: "calendar.badge.plus")!,
                                     text:  model.registered?.date?.toReadableDateString())
        idLabel.addTrailing(image:  UIImage(systemName: "person.badge.key")!, text: model.id?.name)
    }
    
    private func setupLayout() {
        addSubview(genderLabel)
        addSubview(ageLabel)
        addSubview(phoneNumberLabel)
        addSubview(emailLabel)
        addSubview(locationLabel)
        addSubview(timezoneLabel)
        addSubview(usernameLabel)
        addSubview(createdTimeLabel)
        addSubview(idLabel)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        timezoneLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        createdTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Left hand side
        genderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        ageLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10).isActive = true
        ageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        phoneNumberLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10).isActive = true
        phoneNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        timezoneLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10).isActive = true
        timezoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        timezoneLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        // Right hand side
        usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        createdTimeLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10).isActive = true
        createdTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        idLabel.topAnchor.constraint(equalTo: createdTimeLabel.bottomAnchor, constant: 10).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
}
