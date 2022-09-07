//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI
import Kingfisher


struct NewTweetView: View {
    
    //MARK: - Var
    @Binding var isShwoingNewTweetView: Bool
    private let size: CGFloat = 64
    @EnvironmentObject private var viewModel: NewTweetViewModel
    
    //MARK: - MainBody
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top){
                    profileImage
                    
                    tweetTextBox
                    Spacer()
                }
                .padding()
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        navigationBarTweetButton
                    }

                    ToolbarItem(placement: .navigationBarLeading) {
                        navigationBarCancelButton
                    }
                }
                
                Spacer()
            }
        }
        .onChange(of: viewModel.isUploadingDone) { newValue in
            print("Valus changes: \(newValue)")
            if newValue {
                self.isShwoingNewTweetView = false
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView(isShwoingNewTweetView: .constant(true))
    }
}

extension NewTweetView{
    //MARK: - View
    private var navigationBarCancelButton:  some View{
        Button(action:{
            isShwoingNewTweetView.toggle()
        }){
            Text("Cancel")
                .foregroundColor(.blue)
        }
    }
    private var navigationBarTweetButton: some View{
        Button(action:{
            viewModel.uploadTweet()
        }){
            Text("Tweet")
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
    private var profileImage:              some View{
        KFImage(URL(string: viewModel.user.profileImageURL ?? ""))
            .resizable()
            .scaledToFill()
            .clipped()
            .frame(size: size)
            .cornerRadius(size / 2)
    }
    private var tweetTextBox:              some View{
        TextArea("What's happening?", text: $viewModel.tweetText)
            .foregroundColor(.gray)
    }
}

//13:07
//TODO: - Serach: what's happen when we define lots of environment Objects and details about them
//TODO: - We can disable the button based on the text(empty or not)
//TODO: - We can set a character limit and show a circular progress bar for tweet
