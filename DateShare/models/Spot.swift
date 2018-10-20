//
//  Spot.swift
//  DateShare
//
//  Created by Imajin Kawabe on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import Foundation
import Firestore.FIRDocumentSnapshot

class Spot: NSObject {
    
    let sid: String
    let imageRef: String
    
    init(sid: String, imageRef: String) {
        
        self.sid = sid
        self.imageRef = imageRef
        
        super.init()
    }
    
    init?(snapshot: DocumentSnapshot) {
        guard let dictionary = snapshot.data() as? [String : Any],
            let imageRef = dictionary["imageRef"] as? String
            else { return nil }
        
        self.sid = snapshot.documentID
        self.imageRef = imageRef
        
        super.init()
        
    }
    
    var dictValue: [String : Any] {
        
        return [
            "sid":sid,
            "imageRef":imageRef
        ]
    }
    
}

