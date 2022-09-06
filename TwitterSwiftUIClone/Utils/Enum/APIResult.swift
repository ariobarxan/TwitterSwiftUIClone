//
//  APIResult.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/28/22.
//

import Foundation

enum APIResult{
    
    enum Auth: String{
        ///General
        case noResult           = "API Result: It is not yet done"
        case successful         = "API Result: It was successful"
        
        ///Registration
        case imageCompressError = "API Result: Couldn't compress the image"
        case imageStroingError  = "API Result: Couldn't store the image"
        case gettingImageURL    = "API Result: Couldn't get the Image URL"
        case creatingImageURL   = "API Result: Couldn't create the Image URL"
        case error              = "API Result: Couldn't create the user"
        case getUser            = "API Result: Couldn't get the user back"
        case fireStoreStoring   = "API Result: Couldn't store the user data on FireStore"
        
        ///Signin
        case userNamePassError = "API Result: Username or passwor is incorrect"
    }
    
    enum User: String{
        ///General
        case noResult           = "API Result: It is not yet done"
        case successful         = "API Result: It was successful"
        case retreivingError    = "API Result: An error occurred while retreiving the user(s)"
    }
    
    enum FollowUnfollow: String {
        ///General
        case noResult            = "API Result: It is not yet done"
        case successful          = "API Result: It was successful"
        
        ///Follow
        case addToFollowingError = "API Result: Adding to Following was not completed"
        case addToFollowerError  = "API Result: Adding to Follower was not completed"
        
        ///Unfollow
        case deleteFromFollwoingError = "API Result: Deleting from Following was not completed"
        case deleteFromFolloerError   = "API Result: Deleting from Follower was not completed"
    }
    
    enum Tweet: String{
        ///General
        case noResult            = "API Result: It is not yet done"
        case successful          = "API Result: It was successful"
        case retrievetweetsError = "API Result: Retrieving tweets ended with error"
    }

}
