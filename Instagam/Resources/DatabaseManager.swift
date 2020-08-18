//
//  DatabaseManager.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/18/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager{
     static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    //MARK:-Public
    
    /// -Check if userName and Email is availabe
    /// - Parameters
    ///   - email:String representing email
    ///   - userName:String representing userName
    public func canCreateNewUser(email:String, userName:String, completion:(Bool)->Void){
        completion(true)
    }
    
    
    /// -Insert new user data to database
    /// - Parameters
    ///   - email:String representing email
    ///   - userName:String representing userName
    ///   - completion Async callback for result if database entry succesed
    public func insertNewUser(with email:String, username:String, completion:@escaping(Bool)->Void){
        database.child(email.safDatabaseKey()).setValue(["username":username]){error, _ in
            if error == nil{
                //succeded
                completion(true)
                return
            }
            else{
                //failed
                completion(false)
                return
            }
            
        }
    }
   
  
}
