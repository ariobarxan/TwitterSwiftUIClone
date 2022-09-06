//
//  FireStoreCollections.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/28/22.
//

import Foundation

enum FireStoreCollections: String{
    case user          = "users"
    case following     = "followings"
    case follower      = "followers"
    case userFollowing = "user-followings"
    case userFollower  = "user-followers"
    case tweet         = "tweets"
    case tweetLike     = "tweet-likes"
    case userLike      = "user-likes"
    case message       = "messages"
    case recentMessage = "recent-messages"
}
