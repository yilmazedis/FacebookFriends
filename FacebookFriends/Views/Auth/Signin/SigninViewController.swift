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
    
    func signin(errorMessage: String)
    func signin()
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
        label.textColor = .purple
        return label
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.setDefault(iconName: "envelope", placeHolder: "Email")
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.text = "yilmaz@edis.com"
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.setDefault(iconName: "lock", placeHolder: "Password")
        view.isSecureTextEntry = true
        view.enablePasswordToggle()
        view.text = "123456Aa"
        return view
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
        label.textColor = .purple
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
        view.backgroundColor = .lightGray
        applyConstraints()
    }
    
    private func applyConstraints() {
        navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(topStackView)
        view.addSubview(loginStackView)
        view.addSubview(bottomStackView)
        
        topStackView.addArrangedSubview(appIconImageView)
        topStackView.addArrangedSubview(appNameLabel)
        
        forgotPasswordContainerView.addSubview(forgotPasswordButton)
        loginStackView.addArrangedSubview(emailTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(forgotPasswordContainerView)
        loginStackView.addArrangedSubview(loginButton)
        
        bottomStackView.addArrangedSubview(signupLabel)
        bottomStackView.addArrangedSubview(signupButton)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        appIconImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        appIconImageView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        loginStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 30).isActive = true
        loginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        loginStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.topAnchor.constraint(equalTo: forgotPasswordContainerView.topAnchor).isActive = true
        forgotPasswordButton.bottomAnchor.constraint(equalTo: forgotPasswordContainerView.bottomAnchor).isActive = true
        forgotPasswordButton.trailingAnchor.constraint(equalTo: forgotPasswordContainerView.trailingAnchor, constant: -16).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func forgotPasswordButtonAction(_ sender: UIButton) {
        Toast.show(message: "Not Implemented Yet", on: view)
    }
    
    @objc func loginButtonAction(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        interactor?.validateAndSignin(email: email, password: password)
    }
    
    @objc func signupButtonAction(_ sender: UIButton) {
        router?.routeSignup()
    }
}

extension SigninViewController: SigninViewProtocol {    
    func signin(errorMessage: String) {
        Toast.show(message: errorMessage, on: view)
    }
     
    func signin() {
        router?.routeFriendList()
    }
}
