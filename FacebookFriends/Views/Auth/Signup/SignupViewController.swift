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
    
    func signup(errorMessage: String)
    func signup()
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
        let view = UITextField()
        view.setDefault(iconName: "envelope", placeHolder: "Email")
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        return view
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let view = UITextField()
        view.setDefault(iconName: "person", placeHolder: "Full Name")
        view.autocorrectionType = .no
        return view
    }()
    
    
    private lazy var userNameTextField: UITextField = {
        let view = UITextField()
        view.setDefault(iconName: "person.fill", placeHolder: "User Name")
        view.autocorrectionType = .no
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.setDefault(iconName: "lock", placeHolder: "Password")
        view.isSecureTextEntry = true
        view.enablePasswordToggle()
        return view
    }()
    
    private lazy var rePasswordTextField: UITextField = {
        let view = UITextField()
        view.setDefault(iconName: "lock.fill", placeHolder: "Repassword")
        view.isSecureTextEntry = true
        view.enablePasswordToggle()
        return view
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setDefaultAppButton(buttonName: "Signup", fontSize: 20)
        button.setTitleColor(UIColor.white, for: .normal)
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
        label.textColor = .purple
        label.font = UIFont.appMainRegular(fontSize: 15)
        label.text = "Have An Account, So"
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setDefaultClearButton(buttonName: "Login", fontSize: 16)
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - SignupInteractorProtocol
    var interactor: SignupInteractorProtocol?
    var router: SignupRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        applyConstraints()
    }
    
    private func applyConstraints() {
        navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(appIconImageView)
        view.addSubview(signupStackView)
        view.addSubview(bottomStackView)
        
        signupStackView.addArrangedSubview(emailTextField)
        signupStackView.addArrangedSubview(fullNameTextField)
        signupStackView.addArrangedSubview(userNameTextField)
        signupStackView.addArrangedSubview(passwordTextField)
        signupStackView.addArrangedSubview(rePasswordTextField)
        signupStackView.addArrangedSubview(signupButton)
        bottomStackView.addArrangedSubview(loginLabel)
        bottomStackView.addArrangedSubview(loginButton)
        
        appIconImageView.translatesAutoresizingMaskIntoConstraints = false
        appIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        appIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        signupStackView.translatesAutoresizingMaskIntoConstraints = false
        signupStackView.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 15).isActive = true
        signupStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        signupStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fullNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rePasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func signupButtonAction(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let fullName = fullNameTextField.text ?? ""
        let username = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let rePassword = rePasswordTextField.text ?? ""
        
        interactor?.validateAndSignup(email: email, password: password, repassword: rePassword, fullName: fullName, username: username)
    }
    
    @objc private func loginButtonAction(_ sender: UIButton) {
        router?.routeSignin()
    }
}

extension SignupViewController: SignupViewProtocol {
    func signup(errorMessage: String) {
        Toast.show(message: errorMessage, on: view)
    }
    
    func signup() {
        router?.routeFriendList()
    }
}

extension UITextField {
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        let imageName = isSecureTextEntry ? "eye" : "eye.slash"
        button.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func enablePasswordToggle() {
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 8
        button.configuration = configuration
        
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @objc fileprivate func togglePasswordView(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        setPasswordToggleImage(sender)
    }
}
