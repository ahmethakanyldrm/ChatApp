//
//  Service.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 15.02.2023.
//

import Foundation
import FirebaseFirestore

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
}
