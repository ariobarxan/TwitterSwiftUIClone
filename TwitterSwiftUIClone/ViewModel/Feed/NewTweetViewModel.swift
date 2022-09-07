//
//  NewTweetViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/1/22.
//

import SwiftUI

final class NewTweetViewModel: ObservableObject{
    
    //MARK: - Var
    var user: User
    
    @Published var tweetText       = ""
    @Published var isUploadingDone = false
    
    private var tweetRepository = TweetRepository()
    
    //MARK: - Initializer
    init(user: User){
        self.user = user
    }
    
    
    //MARK: - Functions
    func uploadTweet(){
        guard tweetText != "" else {return}
        
        tweetRepository.uploadTweet(tweetText, user: user) { response in
            print(response)
            self.isUploadingDone = true
        }
    }
    
}
//NOTE: - We can have binding var or completion instead of using publisher fo is uploading done
