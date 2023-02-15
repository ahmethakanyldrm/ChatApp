//
//  ChatViewController.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 15.02.2023.
//

import UIKit

class ChatViewController: UICollectionViewController {
    
    // MARK: - Properties
    private let user: User
    
     init(user:User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user.name)
    }
}
