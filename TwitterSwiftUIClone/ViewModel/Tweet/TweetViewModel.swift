//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/1/22.
//

import SwiftUI

final class TweetViewModel: ObservableObject{
    //MARK: - Var
    @Published var didLiked = false
    let tweet: Tweet
    
    private let tweetRepository: TweetRepositoryProtocol
    
    init(repository: TweetRepositoryProtocol = TweetRepository() , tweet: Tweet){
        self.tweetRepository = repository
        self.tweet           = tweet
        checkIfUserLiked()
    }
    
    func likeTweet(){
        tweetRepository.like(tweet: tweet) {
            self.didLiked = true
        }
    }
    
    func unlikeTweet(){
        tweetRepository.unlike(tweet: tweet) {
            self.didLiked = false
        }
    }
    
    func checkIfUserLiked(){
        tweetRepository.checkIfUserLiked(tweet: tweet) { didliked in
            self.didLiked = didliked
        }
    }
}
