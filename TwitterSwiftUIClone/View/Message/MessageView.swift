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
    @State private var showChat = false
    @StateObject private var viewModel = MessageViewModel()
    
    //MARK: - MainBody
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
//            NavigationLink(
//                isActive: $showChat,
//                destination: {ChatView()},
//                label: {Text("")}
//            )
            
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.recentMessages) { recentMessage in
                        NavigationLink(destination: ChatView(user: recentMessage.user)) {
                            ConversationCell()
                        }
                        
                    }
                }
            }
            
            
            FloatingButton(imageName: "envelope", isSystemName: true) {
                isSheetPresented.toggle()
            }
            .sheet(isPresented: $isSheetPresented, onDismiss: {showChat.toggle()}){
                    NewMessageView(isShowingNewMessages: $isSheetPresented)}
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}

//TODO: -
