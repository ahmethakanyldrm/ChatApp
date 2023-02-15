//
//  LoginViewController.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 18.01.2023.
//

import UIKit
import JGProgressHUD

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
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    private var stackView = UIStackView()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var  switchRegistrationPage: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Click To Become A Member", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoToRegisterView), for: .touchUpInside)
        
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
    
    @objc private func handleLoginButton(_ sender: UIButton){
        guard let emailText = emailTextField.text else {return}
        guard let passwordText = passwordTextField.text else {return}
        showProgressHud(showProgress: true)
        AuthenticationService.login(withEmail: emailText, password: passwordText) { result, error in
            if let error = error {
                print("Error ! \(error.localizedDescription)")
                self.showProgressHud(showProgress: false)
                return
            }
            self.showProgressHud(showProgress: false )
            self.dismiss(animated: true)
        }
        
        
        
    }
    
    @objc private func handleTextFieldChange(_ sender: UITextField){
        
        if sender == emailTextField {
            viewModel.emailTextField = sender.text
        }else {
            viewModel.passwordTextField = sender.text
        }
        loginButtonStatus()
    }
    
    @objc private func handleGoToRegisterView(_ sender: UIButton){
        let controller = RegisterViewController()
        self.navigationController?.pushViewController(controller, animated: true)
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
        
        //switch Button
        switchRegistrationPage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout() {
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(switchRegistrationPage)
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
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            // switch
            switchRegistrationPage.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 8),
            switchRegistrationPage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: switchRegistrationPage.trailingAnchor, constant: 32)
            
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
