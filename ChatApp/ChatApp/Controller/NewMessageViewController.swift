//
//  NewMessageViewController.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 15.02.2023.
//

import UIKit
private let reuseIdentifier = "UserCell"

protocol NewMessageViewControllerProtocol: AnyObject {
    func goToChatView(user:User)
}

class NewMessageViewController: UIViewController {

// MARK: - Properties
    
    private let tableView = UITableView()
    private var users = [User]()
    weak var delegate: NewMessageViewControllerProtocol?
    
    
// MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Service.fetchUser { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
}

// MARK: - Helper

extension NewMessageViewController {
    private func style(){
        //tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 75
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}
// MARK: - UITableViewDataSource,UITableViewDelegate
extension NewMessageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.goToChatView(user: users[indexPath.row])
        
    }
}
