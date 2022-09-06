//
//  TweetAPIService.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/1/22.
//

import Foundation
import Firebase

protocol TweetAPIServiceProtocol{

    func uploadTweet(_ tweet: String, user: User, completion: @escaping (_ response: APIResult.Tweet) -> ())
    
    func fetchTweet(completion: @escaping (_ response: APIResult.Tweet, _ querySnapshot: [QueryDocumentSnapshot]) -> ())
    
    func likeTweet(_ tweet: Tweet, completion: @escaping () -> ())
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping () -> ())
    
    func checkIfUserLiked(tweet: Tweet, completion: @escaping (_ documentSnapshot: DocumentSnapshot?) -> ())
    
    func fetchUserTweets(_ user: User, completion: @escaping (_ tweetDocuments: [QueryDocumentSnapshot]) -> ())
    
    func fetchLikedTweets(_ user: User, completion: @escaping (_ likedTweets: [Tweet]) -> ())
}

final class TweetAPIService: TweetAPIServiceProtocol{
    
    private var apiResponse: APIResult.Tweet = .noResult
    private var tweets = [Tweet]()
    
    func uploadTweet(_ tweet: String, user: User, completion: @escaping (_ response: APIResult.Tweet) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let tweetCollectionRefrence = COLLECTION_TWEETS.document()
        
        let data: [String: Any] = ["uid": uid,
                                   "caption": tweet,
                                   "fullName": user.fullname,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageURL": user.profileImageURL ?? "None",
                                   "likes": 0,
                                   "id": tweetCollectionRefrence.documentID]
        
        tweetCollectionRefrence.setData(data) { error in
           // guard let _ = error else {return}
            
            print("DEBUG: Successfully Upload")
            
            self.apiResponse = .successful
            
            completion(self.apiResponse)
        }
        
    }
    
    func fetchTweet(completion: @escaping (_ response: APIResult.Tweet, _ querySnapshot: [QueryDocumentSnapshot]) -> ()){
        COLLECTION_TWEETS.getDocuments { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else {
                self.apiResponse = .retrievetweetsError
                return
            }
            
            self.apiResponse = .successful
            completion(self.apiResponse, documents)
        }
    }
    
    func likeTweet(_ tweet: Tweet, completion: @escaping () -> ()){
        guard let uid     = Auth.auth().currentUser?.uid else {return}
        let tweetLikesRef = COLLECTION_TWEETS.document(tweet.id).collection(FireStoreCollections.tweetLike.rawValue)
        let userLikesRef  = COLLECTION_USERS.document(uid).collection(FireStoreCollections.userLike.rawValue)
        
        COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.like + 1]){ _ in
            tweetLikesRef.document(uid).setData([:]){ _ in
                userLikesRef.document(tweet.id).setData([:]) { _ in
                    completion()
                }
            }
        }
        
    }
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping () -> ()){
        guard let uid     = Auth.auth().currentUser?.uid else {return}
        let tweetLikesRef = COLLECTION_TWEETS.document(tweet.id).collection(FireStoreCollections.tweetLike.rawValue)
        let userLikesRef  = COLLECTION_USERS.document(uid).collection(FireStoreCollections.userLike.rawValue)
        
        COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.like - 1]){ _ in
            tweetLikesRef.document(uid).delete{ _ in
                userLikesRef.document(tweet.id).delete{ _ in
                    completion()
                }
            }
        }
    }
    
    func checkIfUserLiked(tweet: Tweet, completion: @escaping (_ documentSnapshot: DocumentSnapshot?) -> ()){
        guard let uid   = Auth.auth().currentUser?.uid else {return}
        let userLikeRef = COLLECTION_USERS.document(uid).collection(FireStoreCollections.userLike.rawValue).document(tweet.id)
        
        userLikeRef.getDocument { documentSnapshot, error in
            completion(documentSnapshot)
        }
    }
    
    func fetchUserTweets(_ user: User, completion: @escaping (_ tweetDocuments: [QueryDocumentSnapshot]) -> ()){
        
        
        COLLECTION_TWEETS.whereField("uid", isEqualTo: user.uid ?? "").getDocuments { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else {return}
            
            completion(documents)
        }
    }
    
    func fetchLikedTweets(_ user: User, completion: @escaping (_ likedTweetsDocument: [Tweet]) -> ()){
        let userLikeRef = COLLECTION_USERS.document(user.uid ?? "").collection(FireStoreCollections.userLike.rawValue)
        
        userLikeRef.getDocuments { querySnapshot, _ in
            guard let tweetIDsDocument = querySnapshot?.documents else {return}
            
            let tweetIDS = tweetIDsDocument.map({$0.documentID})
        
            returnTweets(tweetIDS: tweetIDS) { tweets in
                completion(tweets)
            }
        }
        
        func returnTweets(tweetIDS: [String], completion: @escaping (_ tweets :[Tweet]) -> ()){
            tweetIDS.forEach { tweetID in
                COLLECTION_TWEETS.document(tweetID).getDocument { documentSnapshot, _ in
                    guard let tweetData = documentSnapshot?.data() else {return}
                    let tweet = Tweet(dictionary: tweetData)
                    
                    self.tweets.append(tweet)
                    guard self.tweets.count == tweetIDS.count else {return}
                    completion(self.tweets)
                }
            }
        }
    }
}
//TODO: - We should really consider using Auth as a singleton
//TODO: - Errors are not handled
