//
//  MessageCell.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 15.02.2023.
//

import UIKit

class MessageCell: UICollectionViewCell {
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
        
    }()
    
    private let messageContainerView: UIView = {
     let containerView = UIView()
        containerView.backgroundColor = .systemBlue
        return containerView
    }()
    
    private let messageTextView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        textView.text = "Message"
        textView.textColor = .white
        return textView
    }()
    // MARK: - LifeCycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Helper

extension MessageCell {
    
    private func style(){
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 34 / 2
        messageContainerView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageContainerView.layer.cornerRadius = 10
        messageContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
    }
    
    private func layout(){
        addSubview(profileImageView)
        addSubview(messageContainerView)
        addSubview(messageTextView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 34),
            profileImageView.heightAnchor.constraint(equalToConstant: 34),
            bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: -8),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 4),
            
            messageContainerView.topAnchor.constraint(equalTo: topAnchor,constant: 4),
            messageContainerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,constant: 8),
            messageContainerView.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            messageTextView.topAnchor.constraint(equalTo: messageContainerView.topAnchor),
            messageTextView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor),
            messageTextView.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor),
            
            
            
        
        ])
        
    }
}
