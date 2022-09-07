//
//  UserProfileView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct UserProfileView: View {
    
    //MARK: - Var
    @State private var selectedFilter: TweetFilterOptions = .tweets
    @EnvironmentObject var viewModel: UserProfileViewModel
    
    //MARK: - view
    var body: some View {
        ScrollView{
            VStack{
                ProfileHeaderView()
                    .padding()
                
                ProfileActionButtonView()
                Spacer()
                
                FilterButtonView(selectedFilter: $selectedFilter)
                    .padding()
                
                showTweets()
                    .padding(.horizontal, 5)
            }
            
        }
        .onAppear {
            viewModel.checkIfFollowed()
        }
        .onChange(of: selectedFilter) { newValue in
            
        }
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
//TODO: - Check if is followed runs late, and user can see that it changes from to follow to unfollow
extension UserProfileView{
    //MARK: - Views
    
    func showTweets() -> some View {
        if selectedFilter == .tweets{
            viewModel.showUserTweets()
            return ForEach(viewModel.userTweets){ tweet in
                        TweetCell(tweet: tweet)
                        .environmentObject(TweetViewModel(tweet: tweet))
            }
        }else{
            viewModel.showLikedTweets()
            return ForEach(viewModel.likedTweets){ tweet in
                        TweetCell(tweet: tweet)
                            .environmentObject(TweetViewModel(tweet: tweet))
                
            }
        }
    }
}
