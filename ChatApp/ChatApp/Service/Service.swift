//
//  Service.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 15.02.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
struct Service {
    static func fetchUser(completion: @escaping([User]) -> Void){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            users = snapshot?.documents.map({User(data: $0.data())}) ?? []
            completion(users)
        }
    }
    
    static func sendMessage(message: String, toUser: User,completion: @escaping(Error?)->Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let data = [
            "text":message,
            "fromId": currentUid,
            "toId":toUser.uid,
            "timestamp": Timestamp(date: Date())
        ] as [String: Any]
        
        Firestore.firestore().collection("messages").document(currentUid).collection(toUser.uid).addDocument(data: data) { error in
            Firestore.firestore().collection("messages").document(toUser.uid).collection(currentUid).addDocument(data: data,completion: completion)
            
        }
        
    }
}
