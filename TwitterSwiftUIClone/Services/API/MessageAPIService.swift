//
//  MessageAPIService.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/3/22.
//

import Foundation
import Firebase

protocol MessageAPIServiceProtocol{
    func sendMessage(_ messageText: String, toUser user: User)
    
    func fetchRecentMessage(completion: @escaping (_ user: User, _ messageDict: [String: Any]) -> ())
}

final class MessageAPIService: MessageAPIServiceProtocol{
    
    //MARK: - Functions
    func sendMessage(_ messageText: String, toUser user: User){
        guard let currentUID = Auth.auth().currentUser?.uid else {return}
        
        let currentUserRef      = COLLECTION_MESSAGES.document(currentUID).collection(user.uid ?? "").document()
        let receivingUserRef    = COLLECTION_MESSAGES.document(user.uid ?? "").collection(currentUID)
        let receivingRecentRef  = COLLECTION_MESSAGES.document(user.uid ?? "").collection(FireStoreCollections.recentMessage.rawValue)
        let currentReceivingRef = COLLECTION_MESSAGES.document(currentUID).collection(FireStoreCollections.recentMessage.rawValue)
        
        let messageID = currentUserRef.documentID
        
        let data: [String: Any] = ["text": messageText,
                                   "id": messageID,
                                   "fromID": currentUID,
                                   "toID": user.uid ?? "",
                                   "timestamp": Timestamp(date: Date())
                                  ]
        
        currentUserRef.setData(data)
        receivingUserRef.document(messageID).setData(data)
        receivingRecentRef.document(currentUID).setData(data)
        currentReceivingRef.document(user.uid ?? "").setData(data)
    }
    
    func fetchRecentMessage(completion: @escaping (_ user: User, _ messageDict: [String: Any]) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let query = COLLECTION_MESSAGES.document(uid).collection(FireStoreCollections.recentMessage.rawValue)
        
        query.order(by: "timestamp", descending: true)
        
        ///Adding observer on the backend
        query.addSnapshotListener { querySnapshot, _ in
            guard let changes = querySnapshot?.documentChanges else {return}
            
            changes.forEach{ change in
                let data = change.document.data()
                let uid  = change.document.documentID
                
                let userRepo = UserRepository()

                userRepo.retrieveUser(with: uid) { user in
                    completion(user, data)
                }
            }
        }
    }
}

//TODO: - Firestore is not the best way to build your messaging module based on, you better of with a real time data base rather than this.
