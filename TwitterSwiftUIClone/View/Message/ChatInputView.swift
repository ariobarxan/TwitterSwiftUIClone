//
//  MessageInputView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct ChatInputView: View {
    
    //MARK: - Var
    @Binding var messageText: String
    
    var action: action
    
    //MARK: - MainBody
    var body: some View {
        HStack {
            TextField("Message", text: $messageText)
                .frame(minHeight: 30)
            
            Button(action: {
               action()
               messageText = ""
            }){
                
                Text("Send")
                
            }
        }
    }
}

//struct ChatInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatInputView(messageText: .constant("Message..."))
//    }
//}
