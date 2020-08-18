//
//  LoginViewController.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/17/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {

    
    struct Constants {
        static let cornerRadius :CGFloat = 8.0
        
    }
    private let userNameEmailField:UITextField = {
        let field = UITextField()
        field.placeholder = "Username or email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField:UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Pasword ..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Constants.cornerRadius
        return button
        
    }()
    
    private let termsButton:UIButton = {
        let button = UIButton()
        button.setTitle("Term of Sevise", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton:UIButton = {
        let button =  UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton:UIButton = {
        let button =  UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New user ?? Create Account", for: .normal)
        return button
    }()
    
    private let headerView:UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didCreateAcountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        userNameEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        //ssign frame for subviews
        headerView.frame = CGRect(x: 0, y: view.top, width: view.with, height: view.height/3)
        userNameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 40, width: view.with-50, height: 52)
        passwordField.frame = CGRect(x: 25, y: userNameEmailField.bottom + 10, width: view.with-50, height: 52)
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.with-50, height: 52)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.with-50, height: 52)
        
        termsButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 100, width: view.with-20, height: 50)
        privacyButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 50, width: view.with-20, height: 50)
         configureHeaderView()
    }
    
    private func  configureHeaderView(){
        guard headerView.subviews.count == 1 else{
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        // add intagram gradient
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.with/4,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.with/2,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
           
    
    private func addSubviews(){
        
        view.addSubview(headerView)
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(createAccountButton)
        view.addSubview(privacyButton)
        
    }

    @objc func didTapLoginButton(){
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        
        guard let userNameEmail = userNameEmailField.text, !userNameEmail.isEmpty,
            let password = userNameEmailField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        //Login Functionality
    }
    @objc func didTapTermButton(){
        guard let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    @objc func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875?helpref=page_content") else { return }
               
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
        
    }
    @objc func didCreateAcountButton(){
        let vc = RegistrationViewController()
        present(vc,animated: true)
    }
   
    
    

}


extension LoginViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailField{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
        
        return true
    }
    
}
