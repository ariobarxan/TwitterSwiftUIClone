//
//  ProfileActionButtonView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
    
    //MARK: - Var
    private let width: CGFloat = 360
    @EnvironmentObject private var viewModel: UserProfileViewModel
    
    
    //MARK: - MainBody
    var body: some View {
        if viewModel.user.isCurrentUser{
            edditButton
        }else{
            HStack{
                followButton
                
                messageButton
            }
        }
        
    }
}

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView()
    }
}

extension ProfileActionButtonView{
    
    private var edditButton:  some View{
        Button(action: {}){
            Text("Edit Profile")
                .frame(width: width, height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
        }
        .cornerRadius(20)
    }
    private var followButton: some View{
        Button(action: {
            viewModel.user.isFollowed ? viewModel.unfollow() : viewModel.follow()
        }){
            Text(viewModel.user.isFollowed ? "Unfollow" : "Follow")
                .frame(width: width / 2, height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
        }
        .cornerRadius(20)
    }
    private var messageButton: some View {
        NavigationLink(destination: ChatView(user: viewModel.user)) {
            Text("Message")
                .frame(width: width / 2, height: 40)
                .background(Color.purple)
                .foregroundColor(.white)
        }
        .cornerRadius(20)
    }
    
}
//TODO: - Send viewmodel via injection rather than environment objects
