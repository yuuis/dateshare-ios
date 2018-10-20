//
//  Post.swift
//  DateShare
//
//  Created by Imajin Kawabe on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import Foundation
import Firestore.FIRDocumentSnapshot

class Post: NSObject  {
    
    var pid: String?
    let uid: String
    let title: String
    let time: Date
    
    init(uid: String, title: String, time: Date) {
        
        self.uid = uid
        self.title = title
        self.time = time
        
        super.init()
        
    }
    
    init?(snapshot: DocumentSnapshot) {
        guard let dictionary = snapshot.data() as? [String : Any],
            let uid = dictionary["uid"] as? String,
            let title = dictionary["title"] as? String,
            let time = dictionary["time"] as? Date
        else { return nil }
        
        self.pid = snapshot.documentID
        self.uid = uid
        self.title = title
        self.time = time
        
        super.init()
        
    }
    
    var dictValue: [String : Any] {
        
        return [
            "pid":pid ?? "error",
            "uid":uid,
            "title":title,
            "time":time
        ]
    }
    
}
