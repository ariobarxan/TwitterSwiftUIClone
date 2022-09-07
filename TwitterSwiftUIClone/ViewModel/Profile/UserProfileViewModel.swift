//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/30/22.
//

import SwiftUI

final class UserProfileViewModel: ObservableObject{
    
    //MARK: - Vars
    @Published var userTweets  = [Tweet]()
    @Published var likedTweets = [Tweet]()
    @Published var user: User
    private var followUnfollowApiService = FollowUnfollowAPIService()
    private var repository: TweetRepositoryProtocol
    
    
    
    
    //MARK: - Initializer
    init(user: User, repository: TweetRepositoryProtocol = TweetRepository()){
        self.repository = repository
        self.user = user
        self.showUserTweets()
        self.showLikedTweets()
        self.showUserStats()
    }
    
    //MARK: - Functions
    func follow(){
        guard  let uid = self.user.uid else { return }
        
        followUnfollowApiService.follow(userWith: uid) { response in
            print("Followed: \(response)")
            self.user.isFollowed = true
        }
    }
    
    func unfollow(){
      
        guard  let uid = self.user.uid else { return }

        followUnfollowApiService.unfollow(userWith: uid) { response in
            print("Unfollow:  \(response)")
            self.user.isFollowed = false
        }
    }
    
    func showUserTweets(){
        repository.getUserTweets(user: user){ tweets in
            self.userTweets = tweets
        }
    }
    
    func showLikedTweets(){
        repository.getLikedTweets(user: user){ tweets in
            self.likedTweets = tweets
        }
    }
    
    func checkIfFollowed(){
        guard  let uid = self.user.uid else { return }
        guard !user.isCurrentUser else {return}
        
        followUnfollowApiService.checkIfUserIsfollowed(with: uid) { response, isFollowed in
            print("Check If Followed: \(response)")
            self.user.isFollowed = isFollowed
        }
    }
    
    func showUserStats(){
        let userRepository = UserRepository()
        
        userRepository.retrieveUserStats(userID: user.uid ?? "") { userStat in
            self.user.stats = userStat
        }
    }
}
