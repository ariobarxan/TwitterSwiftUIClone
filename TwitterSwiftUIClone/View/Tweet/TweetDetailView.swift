//
//  TweetDetailView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/1/22.
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    //MARK: - Var
    @EnvironmentObject private var viewModel: TweetViewModel
    let tweet: Tweet
    
    //MARK: - Mainbody
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
               
                profile
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 4){
                    
                    HStack{
                        name
                        id
                        lastEdit
                    }
                    
                    postText
                    

                }
                
            }
            .padding(.bottom)
            .padding(.trailing)
            dateText
                .padding(.horizontal)
            
            Divider()
            
            likesRetweets
                .padding(.horizontal)
            
            Divider()
            
            HStack{
                commentButton
                Spacer()
                
                retweetButton
                Spacer()
                
                likeButton
                Spacer()
                
                saveButton
      
            }
            .foregroundColor(.gray)
            .padding(.horizontal )
            
            Divider()
            
            Spacer()
        }
        .padding(.top)
    }
}

//struct TweetDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetDetailView()
//    }
//}
//TODO: - Mock Data for all views

extension TweetDetailView{
    //MARK: - View
    private var profile:       some View {
       KFImage(URL(string: tweet.profileImageURL))
            .resizable()
            .scaledToFill()
            .clipped()
            .clipShape(Circle())
            .frame(size: 56)
    }
    private var name:          some View {
        Text(tweet.fullname)
            .font(.system(size: 14, weight: .semibold))
    }
    private var postText:      some View {
       Text(tweet.caption)
    }
    private var lastEdit:      some View {
        Text("2W")
            .foregroundColor(.gray)
            .font(.system(size: 14))
    }
    private var id:            some View {
       Text("\(tweet.username) •")
            .foregroundColor(.gray)
    }
    private var dateText:      some View {
        Text("7:22 PM • 09/01/2022")
            .font(.system(size: 14))
            .foregroundColor(.gray)
    }
    private var likesRetweets: some View {
        HStack{
            HStack(spacing: 4){
                Text("0")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Retweet")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            HStack(spacing: 4){
                Text("0")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Likes")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
    }
    private var commentButton: some View {
        Button(action:{}){
            Image(systemName: "bubble.left")
                .font(.system(size: 16))
                .frame(size: 32)
        }
    }
    private var retweetButton: some View {
        Button(action: {}){
            Image(systemName: "arrow.2.squarepath")
                .font(.system(size: 16))
                .frame(size: 32)
        }
    }
    private var likeButton: some View {
        Button(action: {
            viewModel.didLiked ? viewModel.unlikeTweet() : viewModel.likeTweet()
        }){
            Image(systemName: viewModel.didLiked ? "heart.fill" : "heart")
                .font(.system(size: 16))
                .frame(size: 32)
                .foregroundColor(viewModel.didLiked ? .red : .gray)
        }
    }
    private var saveButton:    some View {
        Button(action: {}){
            Image(systemName: "bookmark")
                .font(.system(size: 16))
                .frame(size: 32)
        }
    }
}
