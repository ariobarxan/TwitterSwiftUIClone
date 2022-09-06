//
//  UserAPIService.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/29/22.
//

import Foundation
import Firebase

protocol UserAPIServiceProtocol{
    var apiResponse: APIResult.User { get }
    
    func fetch(userID uid: String, completion: @escaping (_ response: APIResult.User, _ userDictionaryData: [String : Any]) -> ())
    
    func fetchUsers(completion: @escaping (_ usersQuerySnapshotDocument :[QueryDocumentSnapshot]) -> ())
    
    func fetchUserStats(userID: String, completion: @escaping (_ followingCount: Int, _ followerCount: Int) -> ())
}

final class UserAPIService: UserAPIServiceProtocol{
    
    //MARK: - Var
    var apiResponse: APIResult.User = APIResult.User.noResult
    
    
    //MARK: - Functions

    func fetch(userID uid: String, completion: @escaping (_ response: APIResult.User, _ userDictionaryData: [String : Any]) -> ()) {
        COLLECTION_USERS.document(uid).getDocument { documentSnapShot, error in
            if let _ = error{
                self.apiResponse = .retreivingError
                return
            }
            guard let data = documentSnapShot?.data() else { return }
            self.apiResponse = .successful
            
            completion(self.apiResponse , data)
        }
    }
    
    func fetchUsers(completion: @escaping (_ usersQuerySnapshotDocument :[QueryDocumentSnapshot]) -> ()){
        COLLECTION_USERS.getDocuments { querySnapshot, error in
            guard error == nil else{
                self.apiResponse = .retreivingError
                return
            }
            
            guard let snapshotDocument = querySnapshot?.documents else {return}
            
            completion(snapshotDocument)
        }
    }
    
    func fetchUserStats(userID: String, completion: @escaping (_ followingCount: Int, _ followerCount: Int) -> ()){
        let followerRef  = COLLECTION_FOLLOWERS.document(userID).collection(FireStoreCollections.userFollower.rawValue)
        let followingRef = COLLECTION_FOLLWOINGS.document(userID).collection(FireStoreCollections.userFollowing.rawValue)
        
        
        followerRef.getDocuments { querySnapshot, _ in
            guard let followerCount = querySnapshot?.documents.count else {return}
            
            followingRef.getDocuments { querySnapshot, error in
                guard let followingCount = querySnapshot?.documents.count else {return}
                
                completion(followingCount, followerCount)
            }
        }
    }
    
//    func fetchFilteredUsers(_ filterText: String){
//
//    }
}

//TODO: - Show nothing or mixture of users in the search View and then filter them
