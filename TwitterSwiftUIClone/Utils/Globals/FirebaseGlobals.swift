//
//  FirebaseGlobals.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/30/22.
//

import Foundation
import Firebase


let COLLECTION_USERS      = Firestore.firestore().collection(FireStoreCollections.user.rawValue)
let COLLECTION_FOLLWOINGS = Firestore.firestore().collection(FireStoreCollections.following.rawValue)
let COLLECTION_FOLLOWERS  = Firestore.firestore().collection(FireStoreCollections.follower.rawValue)
let COLLECTION_TWEETS     = Firestore.firestore().collection(FireStoreCollections.tweet.rawValue)
let COLLECTION_MESSAGES   = Firestore.firestore().collection(FireStoreCollections.message.rawValue)
