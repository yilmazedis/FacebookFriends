//
//  FriendListDetailViewController.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import MapKit

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
    
    private lazy var personCardView: PersonCardView = {
        let view = PersonCardView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
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
        
        setImageAutolayout()
        setAutolayout()
        setContents()
        
        personCardView.configure(model: person)
    }
    
    private func setContents() {
        title = person.name?.first + " " + person.name?.last
        
        if let strUrl = person.picture?.large,
           let url = URL(string: strUrl) {
            imageView.networkImage(url: url)
        }
        
        if let lat = person.location?.coordinates?.latitude.value,
           let latDegre = CLLocationDegrees(lat),
           let lng = person.location?.coordinates?.longitude.value,
           let lngDegre = CLLocationDegrees(lng){
            let location = CLLocation(latitude: latDegre,
                                      longitude: lngDegre)
            mapView.putDropPin(at: location)
        }
    }
    
    private func setImageAutolayout() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
        
        contentView.addSubview(personCardView)
        personCardView.translatesAutoresizingMaskIntoConstraints = false
        personCardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        personCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        personCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        personCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        
        contentView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: personCardView.bottomAnchor, constant: 25).isActive = true
        mapView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
