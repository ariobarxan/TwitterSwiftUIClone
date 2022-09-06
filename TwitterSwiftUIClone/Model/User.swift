//
//  AuthUser.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/26/22.
//
import SwiftUI
import Firebase

struct User: Identifiable{
    var id:              String {
        if let UID = uid {
            return UID
        }else{
            return username
        }
    }
    let email:           String
    var pass:            String?
    let username:        String
    let fullname:        String
    var profileImage:    UIImage?
    var profileImageURL: String?
    var uid:             String?
    var isCurrentUser:   Bool
    var stats:           UserStats
    var isFollowed = false
    
  
    ///For authentication purpose
    init(email: String, password: String, userName: String, fullName: String, profileImage: UIImage){
        self.email         = email
        pass               = password
        username           = userName
        fullname           = fullName
        self.profileImage  = profileImage
        self.isCurrentUser = true
        self.stats         = UserStats(following: 0, followers: 0)
    }
    
    ///For repositories
    init(email: String, username: String, fullname: String, profileImageURL: String, uid: String){
        self.email           = email
        self.username        = username
        self.fullname        = fullname
        self.profileImageURL = profileImageURL
        self.uid             = uid
        self.isCurrentUser   = Auth.auth().currentUser?.uid == self.uid
        self.stats           = UserStats(following: 0, followers: 0)
        
    }
    
    init(dictionary: [String: Any]){
        self.uid             = dictionary["uid"] as? String ?? ""
        self.username        = dictionary["username"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageUrl"] as? String ?? ""
        self.email           = dictionary["email"] as? String ?? ""
        self.fullname        = dictionary["fullname"] as? String ?? ""
        self.isCurrentUser   = Auth.auth().currentUser?.uid == self.uid
        self.stats           = UserStats(following: 0, followers: 0)
    }
    
    ///For Showing users in views
    init(email: String, username: String, fullname: String, profileImage: UIImage, uid: String){
        self.email         = email
        self.username      = username
        self.fullname      = fullname
        self.profileImage  = profileImage
        self.uid           = uid
        self.isCurrentUser = Auth.auth().currentUser?.uid == self.uid
        self.stats         = UserStats(following: 0, followers: 0)
    }
}

//TODO: - Search: does having the user's password in the app create a security risk?

//Using this model for only the current user
