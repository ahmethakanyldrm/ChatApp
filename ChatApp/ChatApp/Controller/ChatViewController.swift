//
//  ChatViewController.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 15.02.2023.
//

import UIKit
private let reuseIdentifier = "MessageCell"
class ChatViewController: UICollectionViewController {
    
    
    // MARK: - Properties
    private let user: User
    private lazy var chatInputView = ChatInputView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 0.2))
    
    // MARK: - LifeCycles
     init(user:User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override var inputAccessoryView: UIView? {
        get {return chatInputView}
        
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
// MARK: - Helper

extension ChatViewController {
    private func style(){
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        chatInputView.delegate = self
        
    }
    
    private func layout(){
        
    }
}

// MARK: - UICollectionViewDelegate/DataSource
extension ChatViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        
        return cell
    }
}


extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 60)
    }
}

// MARK: - ChatInputViewProtocol

extension ChatViewController: ChatInputViewProtocol {
    
    func sendMessage(_ chatInputView: ChatInputView, message: String) {
       
        Service.sendMessage(message: message, toUser: user) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
        }
    }
    
    
}
