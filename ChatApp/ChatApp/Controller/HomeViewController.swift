//
//  HomeViewController.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 5.02.2023.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    // MARK: - Properties
    private var messageButton: UIBarButtonItem!
    private var newMessageButton: UIBarButtonItem!
    private var container = Container()
    private let messageViewController = NewMessageViewController()

    private lazy var viewControllers: [UIViewController] = [MessageViewController(),messageViewController]
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationStatus()
        style()
        layout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleMessageButton()
    }
}

// MARK: - Helpers
extension HomeViewController {
    
    private func configureBarItem(text:String, selector: Selector)-> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        return button
    }
    
    private func authenticationStatus(){
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginViewController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }
    }
    
    private func signOut(){
        do {
            try Auth.auth().signOut()
            authenticationStatus()
        } catch  {
            
        }
    }
    private func style(){
        view.backgroundColor = .white
        messageButton = UIBarButtonItem(customView: configureBarItem(text: "Messages", selector: #selector(handleMessageButton)))
        
        newMessageButton = UIBarButtonItem(customView: configureBarItem(text: "New Message", selector: #selector(handleNewMessageButton)))
        
        self.navigationItem.leftBarButtonItems = [messageButton,newMessageButton]
        self.messageViewController.delegate = self
        // container
        configureContainer()
        handleMessageButton()
        
    }
    
    private func layout() {
        
    }
    
    private func configureContainer() {
        guard let containerView = container.view else {return}
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

// MARK: - Selector

extension HomeViewController {
    
    @objc private func handleMessageButton(){
        
        if self.container.children.first == MessageViewController(){return}
        self.container.add(viewControllers[0])
        self.viewControllers[0].view.alpha = 0
        UIView.animate(withDuration: 1) {
            self.messageButton.customView?.alpha = 1
            self.newMessageButton.customView?.alpha = 0.5
            self.viewControllers[0].view.alpha = 1
            self.viewControllers[1].view.frame.origin.x = -1000
        } completion: { _ in
            self.viewControllers[1].remove()
            self.viewControllers[1].view.frame.origin.x = 0
        }
    }
    
    @objc private func handleNewMessageButton(){
        if self.container.children.first == NewMessageViewController(){return}
        self.container.add(viewControllers[1])
        self.viewControllers[1].view.alpha = 0
        UIView.animate(withDuration: 1) {
            self.messageButton.customView?.alpha = 0.5
            self.newMessageButton.customView?.alpha = 1
            self.viewControllers[1].view.alpha = 1
            self.viewControllers[0].view.frame.origin.x = 1000
        } completion: { _ in
            self.viewControllers[0].remove()
            self.viewControllers[0].view.frame.origin.x = 0
        }
        
    }
}

extension HomeViewController: NewMessageViewControllerProtocol {
    func goToChatView(user: User) {
        let controller = ChatViewController(user: user)
        self.navigationController?.pushViewController(controller, animated: true)
        print(user.name)
    }
    
    
}



