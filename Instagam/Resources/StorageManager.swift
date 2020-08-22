//
//  StorageManager.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/18/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import FirebaseStorage

public class StorageManager{
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    
    public enum IGStorageManagerError:Error{
        case failedToDownload
    }
    //MARK:-Public
    
    public func uploadUserPost(model:UserPost,completion:@escaping(Result<URL,Error>)->Void){
        
    }
    
    public func downloadImage(with reference:String, completiom:@escaping(Result<URL,IGStorageManagerError>)-> Void){
        bucket.child(reference).downloadURL(completion: {url, error in
            guard let url = url , error == nil else {
                completiom(.failure(.failedToDownload))
                return
            }
        })
    }
    
}
