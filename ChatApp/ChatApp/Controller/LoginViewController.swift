//
//  LoginViewController.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 18.01.2023.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
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
    
    private let emailTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Email")
        return textField
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        style()
        layout()
    }
}


// MARK: - Helpers

extension LoginViewController {
    
    private func style() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout() {
        
        view.addSubview(logoImageView)
        view.addSubview(emailContainerView)
        
//        logoImageView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            // logo
            logoImageView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // email
            emailContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            emailContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
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
