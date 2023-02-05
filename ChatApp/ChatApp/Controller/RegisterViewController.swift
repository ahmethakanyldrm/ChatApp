//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 5.02.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    private var registerViewModel = RegisterViewModel()
    
    //ContainerView
    private lazy var addCameraButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "camera.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return button
    }()
    
    // sen biraz tembel ol oluşturulmadıysa oluşmasını bekle
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return containerView
    }()
    
    
    private lazy var nameContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: nameTextField)
        return containerView
    }()
    
    
    private lazy var userNameContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: userNameTextField)
        return containerView
    }()
    
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return containerView
    }()
    
    
    // textFields
    private var emailTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Email")
        return textField
    }()
    
    private var nameTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Name")
        return textField
    }()
    
    private var userNameTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "User Name")
        return textField
    }()
    
    private var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password ")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var stackView = UIStackView()

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let switchToLoginPage: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "If you are a member, Login Page", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoToLoginView), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    // MARK: - Selectors
    
    @objc private func handleTextFieldChange(_ sender: UITextField){
        
        if sender == emailTextField {
            registerViewModel.email = sender.text
            
        }else if sender == nameTextField {
            registerViewModel.name = sender.text
        }else if sender == userNameTextField {
            registerViewModel.userName = sender.text
        }else {
            registerViewModel.password = sender.text
        }
        registerButtonStatus()
    }
    @objc private func handleGoToLoginView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func handlePhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true)
    }
}



// MARK: - Helpers

extension RegisterViewController {
    
    private func registerButtonStatus(){
        
        if  registerViewModel.status {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .systemBlue
        }else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    private func style() {
        configureGradientLayer()
        self.navigationController?.navigationBar.isHidden = true
        // addCameraButton
        addCameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        //stackView
        stackView = UIStackView(arrangedSubviews: [emailContainerView,nameContainerView,userNameContainerView,passwordContainerView,registerButton])
        // login button
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // textDidChange
        emailTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        // switchToLogin
        switchToLoginPage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout(){
        view.addSubview(addCameraButton)
        view.addSubview(stackView)
        view.addSubview(switchToLoginPage)
        NSLayoutConstraint.activate([
            addCameraButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            addCameraButton.heightAnchor.constraint(equalToConstant: 150),
            addCameraButton.widthAnchor.constraint(equalToConstant: 150),
            addCameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: addCameraButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            switchToLoginPage.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 8),
            switchToLoginPage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: switchToLoginPage.trailingAnchor, constant: 32)
            
        ])
    }
}
// MARK: - UIImagePickerControllerDelegate - UINavigationControllerDelegate

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        addCameraButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        addCameraButton.layer.cornerRadius = 150 / 2
        addCameraButton.clipsToBounds = true
        addCameraButton.layer.borderColor = UIColor.white.cgColor
        addCameraButton.layer.borderWidth = 2
        addCameraButton.contentMode = .scaleAspectFill
        dismiss(animated: true)
        
    }
}
