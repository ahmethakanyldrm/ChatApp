//
//  RegisterViewModel.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 5.02.2023.
//

import UIKit

struct RegisterViewModel {
    var email: String?
    var name: String?
    var userName: String?
    var password: String?
    
    var status: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && userName?.isEmpty == false && name?.isEmpty == false 
    }
}
