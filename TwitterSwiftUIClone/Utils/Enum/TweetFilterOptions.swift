//
//  FilterButtonEnum.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import Foundation

enum TweetFilterOptions: Int, CaseIterable{
    case tweets
    case replies
    case likes
    
    var title: String{
        
        switch self {
            case .tweets:  return "Tweets"
            case .replies: return "Tweets & Replies"
            case .likes:   return "Likes"
        }
    }
}
