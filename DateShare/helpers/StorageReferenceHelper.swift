//
//  StorageReferenceHelper.swift
//  DateShare
//
//  Created by Imajin Kawabe on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseAuth

extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newUserImageReference(uid: String) -> StorageReference {
        let uid = uid
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/users/\(uid)/\(timestamp).jpg")
    }
    
    static func newPostImageReference() -> StorageReference {
        
        let timestamp = dateFormatter.string(from: Date())
        if let userUID = Auth.auth().currentUser?.uid {
            let uid = userUID
            return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
        } else {
            let uid = "error"
            return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
        }
    }
    
    static func newTopicImageReference(date: String) -> StorageReference {
        return Storage.storage().reference().child("images/topics/\(date).jpg")
    }
}
