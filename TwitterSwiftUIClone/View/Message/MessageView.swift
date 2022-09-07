//
//  MessageView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct MessageView: View {
    
    //MARK: - Var
    @State private var isSheetPresented = false
    @State private var showChat         = false
    @State var user: User?
    @StateObject private var viewModel  = MessageViewModel()
    
    //MARK: - MainBody
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let user = user{
                NavigationLink(
                    isActive: $showChat,
                    destination: {LazyView(ChatView(user: user))},
                    label: {Text("")}
                )
            }

            
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.recentMessages) { recentMessage in
                        NavigationLink(destination: LazyView(ChatView(user: recentMessage.user))) {
                            ConversationCell(message: recentMessage)
                        }
                        
                    }
                }
            }
            
            
            FloatingButton(imageName: "envelope", isSystemName: true) {
                isSheetPresented.toggle()
            }
            .sheet(isPresented: $isSheetPresented, onDismiss: {showChat.toggle()}){
                NewMessageView(isShowingNewMessages: $isSheetPresented, user: self.$user)}
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}

//TODO: -
