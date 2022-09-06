//
//  TweetRepository.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/1/22.
//

import Foundation

protocol TweetRepositoryProtocol{
    func uploadTweet(_ tweet: String, user: User, completion: @escaping (_ response: APIResult.Tweet) -> ())
    
    func fetchTweets(completion: @escaping (_ tweets: [Tweet]) -> ())
    
    func like(tweet: Tweet, completion: @escaping () -> ())
    
    func unlike(tweet: Tweet, completion: @escaping () -> ())
    
    func checkIfUserLiked(tweet: Tweet, completion: @escaping (_ didliked: Bool) -> ())
    
    func getUserTweets(user: User, completion: @escaping (_ tweets: [Tweet]) -> ())
    
    func getLikedTweets(user: User, completion: @escaping (_ likedTweets: [Tweet]) -> ())
}

final class TweetRepository: TweetRepositoryProtocol{
    
    //MARK: - Var
    private var tweetAPIService: TweetAPIServiceProtocol
    private var tweets = [Tweet]()
    private var likedTweets = [Tweet]()
    //MARK: - Initializer
    init(APIService: TweetAPIServiceProtocol = TweetAPIService()) {
        self.tweetAPIService = APIService
    }
    
    //MARK: - Functions
    func uploadTweet(_ tweet: String, user: User, completion: @escaping (_ response: APIResult.Tweet) -> ()) {
        tweetAPIService.uploadTweet(tweet, user: user) { response in
            print("Tweet Response: \(response)")
            completion(response)
        }
    }
    
    func fetchTweets(completion: @escaping (_ tweets: [Tweet]) -> ()){
        tweetAPIService.fetchTweet { response, documents in
            print("DEBUG: Tweet-\(response)")
            
            self.tweets = documents.map({Tweet(dictionary: $0.data())})
            
            completion(self.tweets)
        }
    }
    
    func like(tweet: Tweet, completion: @escaping () -> ()){
        tweetAPIService.likeTweet(tweet) {
            completion()
        }
    }
    
    func unlike(tweet: Tweet, completion: @escaping () -> ()){
        tweetAPIService.unlikeTweet(tweet) {
            completion()
        }
    }
    
    func checkIfUserLiked(tweet: Tweet, completion: @escaping (_ didliked: Bool) -> ()){
        tweetAPIService.checkIfUserLiked(tweet: tweet) { documentSnapshot in
            let didLiked = documentSnapshot?.exists
            completion(didLiked ?? false)
        }
    }
    
    func getUserTweets(user: User, completion: @escaping (_ tweets: [Tweet]) -> ()){
        var tweets = [Tweet]()
        tweetAPIService.fetchUserTweets(user) { tweetDocuments in
            tweets = tweetDocuments.map({Tweet(dictionary: $0.data())})
            
            completion(tweets)
        }
    }
    
    func getLikedTweets(user: User, completion: @escaping (_ likedTweets: [Tweet]) -> ()){
        tweetAPIService.fetchLikedTweets(user) { likedTweets in

            completion(likedTweets)
        }
    }
    
}


