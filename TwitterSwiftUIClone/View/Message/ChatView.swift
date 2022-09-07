//
//  ConversationView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct ChatView: View {
    
    //MARK: - Var
    @State private var text: String = ""
    let user: User
    let viewModel: ChatViewModel
    
    //MARK: - Initializer
    init(user: User){
        self.user = user
        self.viewModel = ChatViewModel(user: user)
    }
    
    //MARK: - MainBody
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 12){
                    ForEach(MOCK_MESSAGE){ message in
                        HStack(alignment: .bottom, spacing: 0){
                            
                            if message.isCurrentUser{
                                Image(message.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(size: 40)
                                    .clipShape(Circle())
                                    
                            }
                            
                            ChatBubble(message: message)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            ChatInputView(messageText: $text){
                viewModel.sendMessages(text)
            }
                .padding()
            
                .navigationTitle(user.username)
        }
    }
}

//struct ConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
