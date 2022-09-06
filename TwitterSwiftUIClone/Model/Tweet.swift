//
//  Tweet.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/1/22.
//

import Foundation
import Firebase

struct Tweet: Identifiable{
    let id: String //tweet uid
    let username: String
    let profileImageURL: String
    let fullname: String
    let caption: String
    let like: Int
    let uid: String
    let timeStamp: Timestamp
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]){
        self.id              = dictionary["id"] as? String ?? ""
        self.username        = dictionary["username"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
        self.fullname        = dictionary["fullname"] as? String ?? ""
        self.caption         = dictionary["caption"] as? String ?? ""
        self.like            = dictionary["likes"] as? Int ?? 0
        self.uid             = dictionary ["uid"] as? String ?? ""
        self.timeStamp       = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}


//TODO: - Store the dictionary fields string in an enum
