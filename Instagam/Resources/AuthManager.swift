//
//  AuthManager.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/18/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import FirebaseAuth

public class AuthManager{
    
     static let shared = AuthManager()
    
    //MARK:-Public
    
    public func RegisterNewUser(username:String,email:String, password:String,completion:@escaping(Bool)->Void){
        //Check if useraname is available
        //Check if email is available
        //Create account
        //Insert Account to Database
        DatabaseManager.shared.canCreateNewUser(email: email, userName: username) { (canCreate) in
            if canCreate {
                //Create Account
                //Intert to Database
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil, result != nil else{
                        completion(false)
                        return
                    }
                    //Insert to Database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { (inserted) in
                        if inserted{
                            completion(true)
                            return
                        }
                        else{
                            //Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }
            else{
                //useranem or email doesnt exist
                completion(false)
            }
        }
    }
    public func LoginUser(username:String?,email:String?, password:String,completion: @escaping(Bool)->Void){
        if let email = email{
            //email login
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                
                guard authResult != nil , error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username{
            //username login
            print(username)
            
        }
    }
    
}

