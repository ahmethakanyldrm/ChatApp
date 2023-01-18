//
//  LoginViewController.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 18.01.2023.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    private let logoImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "ellipsis.message")
        imageView.tintColor = .white
        return imageView
    }()
    
    // sen biraz tembel ol oluşturulmadıysa oluşmasını bekle
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return containerView
    }()
    
    private var emailTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Email")
        return textField
    }()
    
    
    
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return containerView
    }()
    
    private var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password ")
        return textField
    }()
    
    
    private var stackView = UIStackView()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.isEnabled = false
        return button
    }()
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        style()
        layout()
    }
}

// MARK: - Selector

extension LoginViewController {
    
    @objc private func handleTextFieldChange(_ sender: UITextField){
        
        if sender == emailTextField {
            viewModel.emailTextField = sender.text
        }else {
            viewModel.passwordTextField = sender.text
        }
        loginButtonStatus()
    }
}


// MARK: - Helpers

extension LoginViewController {
    private func loginButtonStatus(){
        
        if  viewModel.status {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemBlue
        }else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    private func style() {
        self.navigationController?.navigationBar.isHidden = true 
        // Logo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        // email
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        // stackView
        stackView = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        // login button
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // email and password TextField
        emailTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
    }
    private func layout() {
        view.addSubview(logoImageView)
        view.addSubview(stackView)
// logoImageView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            // logo
            logoImageView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // email
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }

}

/*
 
 //        let imageView = UIImageView()
 //        imageView.contentMode = .scaleAspectFill
 //        imageView.clipsToBounds = true
 //        imageView.image = UIImage(systemName: "envelope")
 //        imageView.tintColor = .white
 //        imageView.translatesAutoresizingMaskIntoConstraints = false
 //        containerView.addSubview(imageView)
 //        emailTextField.translatesAutoresizingMaskIntoConstraints = false
 //        containerView.addSubview(emailTextField)
 //
 //        NSLayoutConstraint.activate([
 //            // Container -> ImageView
 //            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
 //            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
 //            imageView.widthAnchor.constraint(equalToConstant: 24),
 //            imageView.heightAnchor.constraint(equalToConstant: 24),
 //
 //            // Container -> EmailTextField
 //            emailTextField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
 //            emailTextField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
 //            containerView.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: 8)
 //
 //        ])
         
 
 
 */
