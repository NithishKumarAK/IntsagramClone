//
//  LoginViewController.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/17/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private let userNameField:UITextField = {
        return UITextField()
    }()
    
    private let passwordField:UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton:UIButton = {
        return UIButton()
    }()
    
    private let termsButton:UIButton = {
           return UIButton()
    }()
    
    private let privacyButton:UIButton = {
           return UIButton()
    }()
    private let createAccountButton = {
        return UIButton()
    }()
    
    private let headerView:UIView = {
        return UIView()
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //ssign frame for subviews
        
    }
    
    private func addSubviews(){
        
        view.addSubview(headerView)
        view.addSubview(userNameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(createAccountButton)
        view.addSubview(privacyButton)
        
    }

    @objc func didTapLoginButton(){}
    @objc func didTapTermButton(){}
    @objc func didTapPrivacyButton(){}
    @objc func didCreateAcountButton(){}
   
    
    

}
