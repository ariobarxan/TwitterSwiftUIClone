//
//  FollowUnFollowAPIService.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/30/22.
//

import Foundation
import Firebase

protocol FollowUnfollowAPIServiceProtocol{
    func follow(userWith uid: String, completion: @escaping (_ response: APIResult.FollowUnfollow) -> ())
    
    func unfollow(userWith uid: String,  completion: @escaping (_ response: APIResult.FollowUnfollow) -> ())
}

final class FollowUnfollowAPIService: FollowUnfollowAPIServiceProtocol{
    
    var apiResponse: APIResult.FollowUnfollow = .noResult
    
    func follow(userWith uid: String, completion: @escaping (_ response: APIResult.FollowUnfollow) -> ()){
        
        addToFollowings(followingUserID: uid) { currentUserID, followingUserID in
            addToFollowers(of: followingUserID, currentUserID: currentUserID) {
                completion(self.apiResponse)
            }
        }

        ///Nested Functions
        func addToFollowings(followingUserID: String ,completion: @escaping (_ cuurentUserID: String, _ followingUserID: String) -> ()){
            
            guard let followerUserID = Auth.auth().currentUser?.uid else {return}
            
            let followingCollectionRefrence = COLLECTION_FOLLWOINGS.document(followerUserID).collection(FireStoreCollections.userFollowing.rawValue)
            
            followingCollectionRefrence.document(followingUserID).setData([:]) { error in
                guard error == nil else {
                    self.apiResponse = .addToFollowingError
                    return
                }
                
                completion(followerUserID, followingUserID)
            }
        }
        
        func addToFollowers(of followingUserID: String, currentUserID: String, completion: @escaping () -> ()){
            let followersCollectionRefrence =  COLLECTION_FOLLOWERS.document(followingUserID).collection(FireStoreCollections.userFollower.rawValue)
            
            followersCollectionRefrence.document(currentUserID).setData([:]) { error in
                guard error == nil else {
                    self.apiResponse = .addToFollowerError
                    return
                }
                self.apiResponse = .successful
                completion()
            }
        }
    }
    
    func unfollow(userWith uid: String,  completion: @escaping (_ response: APIResult.FollowUnfollow) -> ()){
                
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let followingRef     = COLLECTION_FOLLWOINGS.document(currentUid).collection(FireStoreCollections.userFollowing.rawValue)
        let followerRef      = COLLECTION_FOLLOWERS.document(uid).collection(FireStoreCollections.userFollower.rawValue)


        followingRef.document(uid).delete { _ in
            followerRef.document(currentUid).delete { _ in
                self.apiResponse = .successful
                completion(self.apiResponse)
            }
        }
    }
    
    func checkIfUserIsfollowed(with uid: String, completion: @escaping (_ response: APIResult.FollowUnfollow, _ isFollowed: Bool) -> ()){
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        
        let followingCollectionRefrence = COLLECTION_FOLLWOINGS.document(currentUserID).collection(FireStoreCollections.userFollowing.rawValue)
        
        followingCollectionRefrence.document(uid).getDocument { documentSnapShot, error in
            guard let isFollowed = documentSnapShot?.exists else {
                self.apiResponse = .noResult
                return
                
            }
            self.apiResponse = .successful
            completion(self.apiResponse, isFollowed)
        }
    }
}
