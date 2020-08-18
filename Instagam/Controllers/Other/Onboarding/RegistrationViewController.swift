//
//  RegistrationViewController.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/17/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
     struct Constants {
            static let cornerRadius :CGFloat = 8.0
            
        }
    
    private let userNameField:UITextField = {
           let field = UITextField()
           field.placeholder = "Username..."
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
    
  private let EmailField:UITextField = {
           let field = UITextField()
           field.placeholder = "email..."
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
       private let registerButton:UIButton = {
            let button = UIButton()
            button.setTitle("Sign up", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.masksToBounds = true
            button.backgroundColor = .systemGreen
            button.layer.cornerRadius = Constants.cornerRadius
            return button
              
          }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = .systemBackground
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        view.addSubview(userNameField)
        view.addSubview(EmailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        userNameField.delegate = self
        EmailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userNameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.with-40, height: 52)
        EmailField.frame = CGRect(x: 20, y: userNameField.bottom+10, width: view.with-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: EmailField.bottom+10, width: view.with-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.with-40, height: 52)
    }
    

    
    @objc func didTapRegister(){
        userNameField.resignFirstResponder()
        EmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = EmailField.text, !email.isEmpty,
              let username = userNameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else  {   return   }
        
        AuthManager.shared.RegisterNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    //good to go
                    
                    
                }else{
                    //failed
                    
                    
                }
            }
        }
        
     }
    

}
extension RegistrationViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField{
            EmailField.becomeFirstResponder()
        }
        else if textField == EmailField {
            passwordField.becomeFirstResponder()
        }
        else{
            didTapRegister()
        }
        return true
    }
    
    
}
