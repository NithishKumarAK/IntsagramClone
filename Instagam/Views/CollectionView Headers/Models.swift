//
//  Models.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/23/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import Foundation

enum gender{
    case male, female, other
}
struct UserCount {
    let following:Int
    let follower:Int
    let post:Int
}

struct User {
    let userName:String
    let bio:String
    let name:(first:String, last:String)
    let profilePhoto:URL
    let birthDate:Date
    let gender:gender
    let count:UserCount
    let joinedDate:Date
}

public enum UserPostType{
    case phot, video
}

/// Represents user post
public struct UserPost {
    
    let identifier:String
    let postType:UserPostType
    let thumbnailImage:URL
    let postURL:URL
    let caption:String?
    let likeCount:[PostLike]
    let comment:[PostComment]
    let craetedDate:Date
    let taggedUser:[String]
    
    
}
struct PostComment {
    
    let identifier:String
    let userName:String
    let text:String
    let createdDate:Date
    let likes:[CommentLike]
    
}
struct PostLike{
    let userName:String
    let postIdentifier:String
}
struct CommentLike{
    let userName:String
    let commentIdentifier:String
}
