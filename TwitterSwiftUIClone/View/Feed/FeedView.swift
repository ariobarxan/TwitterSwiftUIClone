//
//  FeedView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/23/22.
//

import SwiftUI

struct FeedView: View{
    
    //MARK: - Var
    @State private var isSheetPresented = false
    
    @EnvironmentObject private var authenticationViewModel: SignInViewModel
    
    @StateObject private var viewModel = FeedViewModel()
    
    //MARK: - MainBody
    var body: some View{
        ZStack(alignment: .bottomTrailing) {
            
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.tweets) { tweet in
                        TweetCell(tweet: tweet)
                            .environmentObject(TweetViewModel(tweet: tweet))
                    }
                }
            }
            
            
            FloatingButton(imageName: icons.tweet.rawValue) {
                isSheetPresented.toggle()
            }
        }.fullScreenCover(isPresented: $isSheetPresented, onDismiss: {}) {
            if let user = authenticationViewModel.user{
                NewTweetView(isShwoingNewTweetView: $isSheetPresented)
                    .environmentObject(NewTweetViewModel(user: user))
            }
        }
        .onChange(of: isSheetPresented) { newValue in
            if !newValue {
                viewModel.showTweets()
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationView{
            FeedView()
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension FeedView{
    
    //MARK: - Views
   
}

//TODO: - Log out option tweet
//https://www.brainyquote.com/
