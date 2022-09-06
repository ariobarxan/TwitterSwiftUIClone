//
//  Message.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI
import Firebase

struct MockMessage: Identifiable{
    let id: Int
    let imageName: String
    let messageText: String
    let isCurrentUser: Bool
}

let MOCK_MESSAGE: [MockMessage] = [
    .init(id: 1, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true),
    .init(id: 2, imageName: "Spiderman", messageText: "Hey what is up", isCurrentUser: false),
    .init(id: 3, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true),
    .init(id: 4, imageName: "Spiderman", messageText: "Hey what is up", isCurrentUser: false),
    .init(id: 5, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true),
    .init(id: 6, imageName: "Spiderman", messageText: "Hey what is up", isCurrentUser: false),
    .init(id: 7, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true),
    .init(id: 8, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true),
    .init(id: 9, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true),
    .init(id: 10, imageName: "Spiderman", messageText: "Hey what is up", isCurrentUser: false),
    .init(id: 11, imageName: "Spiderman", messageText: "Hey what is up", isCurrentUser: false),
    .init(id: 12, imageName: "Spiderman", messageText: "Hey what is up", isCurrentUser: false),
    .init(id: 13, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true),
    .init(id: 14, imageName: "Spiderman", messageText: "Hey what is up", isCurrentUser: false),
    .init(id: 15, imageName: "Spiderman", messageText: "Hey what is up", isCurrentUser: false),
    .init(id: 16, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true),
    .init(id: 17, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true),
    .init(id: 18, imageName: "batman", messageText: "Hey what is up", isCurrentUser: true)
]

struct Message: Identifiable{
    let id:     String
    let text:   String
    let user:   User
    let toID:   String
    let fromID: String
    let isFromCurrentUser: Bool
    let timeStamp:         Timestamp
    
    var characterParrentID: String {return isFromCurrentUser ? toID : fromID}
    
    init(user: User, dictionary: [String: Any]){
        self.user = user
        
        self.text   = dictionary["text"] as? String ?? ""
        self.toID   = dictionary["toID"] as? String ?? ""
        self.fromID = dictionary["fromdID"] as? String ?? ""
        self.id     = dictionary["id"] as? String ?? ""
        
        self.isFromCurrentUser = fromID == Auth.auth().currentUser?.uid
        self.timeStamp         = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
       
    }
}
