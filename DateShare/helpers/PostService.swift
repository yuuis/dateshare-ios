//
//  PostService.swift
//  DateShare
//
//  Created by Imajin Kawabe on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import Foundation
import FirebaseStorage
import Firestore

struct PostService {
    static func createPost(for uid: String, title: String, time: Date, spotsInfo: [String:String], completion: @escaping (Bool, Post?) -> Void) {
        
        let rootRef = Firestore.firestore()
        let newPostRef = rootRef.collection("posts").document()
        
        let post = Post(uid: uid, title: title, time: time)
        post.pid = newPostRef.documentID
        
        guard let newPid = post.pid else { return completion(false, nil) }
        
        rootRef.collection("posts").document(newPid).setData(post.dictValue) { error in
            if let error = error {
                print("posting error: \(error)")
                return completion(false, nil)
            } else {
                createSpot(pid: newPid, spotsInfo: spotsInfo, completion: { (success) in
                    if success {
                        return completion(true, post)
                    } else {
                        return completion(false, nil)
                    }
                })
            }
        }
    }
    
    private static func createSpot(pid: String, spotsInfo: [String : String], completion: @escaping (Bool) -> Void) {
        
        let rootRef = Firestore.firestore()
        let postRef = rootRef.collection("posts").document(pid).collection("spots")
        
        let dispatchGroup = DispatchGroup()
        
        for (sid, imageRef) in spotsInfo {
            dispatchGroup.enter()
            let spot = Spot(sid: sid, imageRef: imageRef)
            postRef.document(sid).setData(spot.dictValue) { error in
                if let error = error {
                    print("posting error: \(error)")
                    return completion(false)
                }
                
                dispatchGroup.leave()
                
            }
            
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            completion(true)
        })
        
    }
    
}
