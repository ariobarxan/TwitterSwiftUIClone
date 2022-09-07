//
//  ContentView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/23/22.
//

import SwiftUI
import Kingfisher

struct MainTabView: View {
    
    //MARK: - Var
    @EnvironmentObject private var viewModel: SignInViewModel
    
    //MARK: - MainBody
    var body: some View {
            TabView{
                ///First Tab: Home Feed
                FeedView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                ///Second Tab: Search Tab
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                ///Thir Tab: Direct Messages
                MessageView()
                    .tabItem {
                        Image(systemName: "envelope")
                        Text("Messages")
                    }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    showUserProfile()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.signOut()
                    }){
                        Text("Sign out")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .onAppear{
                viewModel.fetchUser()
            }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

extension MainTabView{
    func showUserProfile() -> some View {
        
        if let user = viewModel.user {
            return AnyView(
                NavigationLink(destination: {
                    UserProfileView()
                    .environmentObject(UserProfileViewModel(user: user))
            }){
                KFImage(URL(string: viewModel.user?.profileImageURL ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(size: 30)
                    .clipShape(Circle())
            })
        }else {
            return AnyView( Button(action: {}){
                KFImage(URL(string: viewModel.user?.profileImageURL ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(size: 30)
                    .clipShape(Circle())
            }
            )
        }
       
    }
}

//TODO: - Take care of force unwrap here
