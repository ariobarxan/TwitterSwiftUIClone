//
//  ProfileHeaderView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
    //MARK: - Var
    private let size: CGFloat = 120
    @EnvironmentObject private var viewModel: UserProfileViewModel
    
    //MARK: - MainBody
    var body: some View {
        VStack{
            profileImage
            
            nameText
            id
            
            bioText
            
            HStack(spacing: 40){
                followers
                
                following
            }
            .padding()
        }
    }
}

//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView()
//    }
//}

extension ProfileHeaderView{
    //MARK: - View
    private var profileImage: some View {
        KFImage(URL(string: viewModel.user.profileImageURL ?? ""))
            .resizable()
            .scaledToFill()
            .clipped()
            .frame(size: size)
            .cornerRadius(size / 2)
            .shadow(color: .black, radius: 6, x: 0.0, y: 0.0)
    }
    private var nameText:     some View {
        Text(viewModel.user.fullname)
            .font(.system(size: 16, weight: .semibold))
            .padding(.top, 8)
    }
    private var id:           some View {
        Text("@\(viewModel.user.username)")
            .font(.subheadline)
            .foregroundColor(.gray)
    }
    private var bioText:      some View {
        Text("DC Universial . Anti-Hero . Parasite")
            .font(.system(size: 14))
            .padding(.top, 8)
    }
    private var followers:    some View {
        VStack{
            Text("\(viewModel.user.stats.followers)")
                .font(.system(size: 16, weight: .bold))
            
            Text("Followers")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    private var following:    some View {
        VStack{
            Text("\(viewModel.user.stats.following)")
                .font(.system(size: 16, weight: .bold))
            
            Text("Following")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}
