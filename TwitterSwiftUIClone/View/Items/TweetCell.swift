//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/23/22.
//

import SwiftUI
import Kingfisher

struct TweetCell: View {
    
    //MARK: - Var
    let tweet: Tweet
    @EnvironmentObject private var viewModel: TweetViewModel
    
    init(tweet: Tweet){
        self.tweet = tweet
        
    }
    
    //MARK: - MainBody
    var body: some View {
        
        VStack(alignment: .leading) {
            NavigationLink(destination:
                            TweetDetailView(tweet: tweet)
                .environmentObject(viewModel)
            ){
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
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            }
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
        }
      
    }
    
}


//struct TweetCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetCell()
//    }
//}

extension TweetCell{
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
    private var likeButton:    some View {
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
    
}
