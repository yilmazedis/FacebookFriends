//
//  SigninViewController.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import UIKit

typealias SigninEntryPoint = SigninViewProtocol & UIViewController

protocol SigninViewProtocol: AnyObject {
    var interactor: SigninInteractorProtocol? { get set }
    var router: SigninRouterProtocol? { get set }
    
    func updateData(data: [Person])
}

final class SigninViewController: UIViewController {
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var appIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "facebookLogo")
        return view
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Facebook Friends"
        label.textAlignment = .center
        label.font = UIFont.appMainBold(fontSize: 35)
        label.textColor = UIColor.purple()
        return label
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.setDefault(iconName: "envelope", placeHolder: "Email")
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setDefault(iconName: "lock", placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var forgotPasswordContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setDefaultClearButton(buttonName: "Forgot Password", fontSize: 16)
        button.addTarget(self, action: #selector(forgotPasswordButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setDefaultAppButton(buttonName: "Sign in", fontSize: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var signupLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.purple()
        label.font = UIFont.appMainRegular(fontSize: 15)
        label.text = "No Account? Then"
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setDefaultClearButton(buttonName: "Sign Up", fontSize: 16)
        button.addTarget(self, action: #selector(signupButtonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - SigninInteractorProtocol
    var interactor: SigninInteractorProtocol?
    var router: SigninRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.background()
        self.applyConstraints()
    }
    
    private func applyConstraints() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.view.addSubview(self.topStackView)
        self.view.addSubview(self.loginStackView)
        self.view.addSubview(self.bottomStackView)
        
        self.topStackView.addArrangedSubview(self.appIconImageView)
        self.topStackView.addArrangedSubview(self.appNameLabel)
        
        self.forgotPasswordContainerView.addSubview(self.forgotPasswordButton)
        self.loginStackView.addArrangedSubview(self.emailTextField)
        self.loginStackView.addArrangedSubview(self.passwordTextField)
        self.loginStackView.addArrangedSubview(self.forgotPasswordContainerView)
        self.loginStackView.addArrangedSubview(self.loginButton)
        
        self.bottomStackView.addArrangedSubview(self.signupLabel)
        self.bottomStackView.addArrangedSubview(self.signupButton)
        
        self.topStackView.translatesAutoresizingMaskIntoConstraints = false
        self.topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        self.topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        self.topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        self.appIconImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        self.appIconImageView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        
        self.loginStackView.translatesAutoresizingMaskIntoConstraints = false
        self.loginStackView.topAnchor.constraint(equalTo: self.topStackView.bottomAnchor, constant: 30).isActive = true
        self.loginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        self.loginStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        self.emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        self.forgotPasswordButton.topAnchor.constraint(equalTo: self.forgotPasswordContainerView.topAnchor).isActive = true
        self.forgotPasswordButton.bottomAnchor.constraint(equalTo: self.forgotPasswordContainerView.bottomAnchor).isActive = true
        self.forgotPasswordButton.trailingAnchor.constraint(equalTo: self.forgotPasswordContainerView.trailingAnchor, constant: -16).isActive = true
        self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.bottomStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func forgotPasswordButtonAction(_ sender: UIButton) {
        //let email = self.emailTextField.text ?? ""
    }
    
    @objc func loginButtonAction(_ sender: UIButton) {
        
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        router?.routeFriendList()
    }
    
    @objc func signupButtonAction(_ sender: UIButton) {
        router?.routeSignup()
    }
}

extension SigninViewController: SigninViewProtocol {
    func updateData(data: [Person]) {

    }
}
