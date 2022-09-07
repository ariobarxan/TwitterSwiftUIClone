//
//  ConversationView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI
import Kingfisher

struct ChatView: View {
    
    //MARK: - Var
    @State private var text: String = ""
    let user: User
    @ObservedObject var viewModel: ChatViewModel
    
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
                    ForEach(viewModel.messages){ message in
                        HStack(alignment: .center, spacing: 0){
                            
                            if message.isFromCurrentUser{
                                KFImage(URL(string: viewModel.user.profileImageURL ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(size: 40)
                                    .clipShape(Circle())
                                    .padding(.leading, 5)
                                    
                            }
                            
                            ChatBubble(message: message)
                        }
                       
                      
                    }
                }
            }
            
            ChatInputView(messageText: $text){
                viewModel.sendMessages(text)
            }
                .padding()
            
                .navigationTitle(user.username)
        }
        .onAppear{
            viewModel.showMessages()
        }
    }
}

//struct ConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
//TODO: - Examine why it navigate out after sending the text message
