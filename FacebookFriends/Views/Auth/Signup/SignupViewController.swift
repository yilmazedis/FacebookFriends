//
//  SignupViewController.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

typealias SignupEntryPoint = SignupViewProtocol & UIViewController

protocol SignupViewProtocol: AnyObject {
    var interactor: SignupInteractorProtocol? { get set }
    var router: SignupRouterProtocol? { get set }
    
    func updateData(data: [Person])
}

final class SignupViewController: UIViewController {
    
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appLogo")
        return imageView
    }()
    
    private lazy var signupStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.setDefault(iconName: "envelope", placeHolder: "signup.email")
        return textField
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.setDefault(iconName: "person", placeHolder: "signup.fullName")
        return textField
    }()
    
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.setDefault(iconName: "person.fill", placeHolder: "signup.userName")
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setDefault(iconName: "lock", placeHolder: "signup.password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var rePasswordTextField: UITextField = {
        let textField = UITextField()
        textField.setDefault(iconName: "lock.fill", placeHolder: "signup.password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setDefaultAppButton(buttonName: "signup.signupButton", fontSize: 16)
        button.addTarget(self, action: #selector(signupButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.purple()
        label.font = UIFont.appMainRegular(fontSize: 15)
        label.text = "signup.doHaveAnAccount"
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setDefaultClearButton(buttonName: "signup.loginButton", fontSize: 16)
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - SignupInteractorProtocol
    var interactor: SignupInteractorProtocol?
    var router: SignupRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.background()
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.view.addSubview(self.appIconImageView)
        self.view.addSubview(self.signupStackView)
        self.view.addSubview(self.bottomStackView)
        
        self.signupStackView.addArrangedSubview(self.emailTextField)
        self.signupStackView.addArrangedSubview(self.fullNameTextField)
        self.signupStackView.addArrangedSubview(self.userNameTextField)
        self.signupStackView.addArrangedSubview(self.passwordTextField)
        self.signupStackView.addArrangedSubview(self.rePasswordTextField)
        self.signupStackView.addArrangedSubview(self.signupButton)
        
        self.bottomStackView.addArrangedSubview(self.loginLabel)
        self.bottomStackView.addArrangedSubview(self.loginButton)
        
        self.appIconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.appIconImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.appIconImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.signupStackView.translatesAutoresizingMaskIntoConstraints = false
        self.signupStackView.topAnchor.constraint(equalTo: self.appIconImageView.bottomAnchor, constant: 15).isActive = true
        self.signupStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        self.signupStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        self.emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.fullNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.userNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.rePasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.bottomStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    @objc private func signupButtonAction(_ sender: UIButton) {
        let email = self.emailTextField.text ?? ""
        let fullName = self.emailTextField.text ?? ""
        let userName = self.emailTextField.text ?? ""
        let password = self.emailTextField.text ?? ""
        let rePassword = self.emailTextField.text ?? ""
        
    }
    
    @objc private func loginButtonAction(_ sender: UIButton) {
        router?.routeSignin()
    }
}

extension SignupViewController: SignupViewProtocol {
    func updateData(data: [Person]) {

    }
}
