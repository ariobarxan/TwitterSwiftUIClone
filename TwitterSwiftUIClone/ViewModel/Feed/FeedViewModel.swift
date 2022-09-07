//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/1/22.
//

import SwiftUI

final class FeedViewModel: ObservableObject{
    @Published var tweets = [Tweet]()
    
    private var tweetRepository = TweetRepository()
    
    init() {
        showTweets()
    }

    func showTweets(){
        tweetRepository.fetchTweets { tweets in
            self.tweets = tweets
        }
    }


}
