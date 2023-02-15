//
//  UIViewController+Ext.swift
//  ChatApp
//
//  Created by AHMET HAKAN YILDIRIM on 18.01.2023.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
    
    func showProgressHud(showProgress: Bool){
        let progressHud = JGProgressHUD()
        progressHud.textLabel.text = "Plase Wait"
        showProgress ? progressHud.show(in: view):progressHud.dismiss()
        
        
    }
    
}
