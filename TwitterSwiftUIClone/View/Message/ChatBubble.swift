//
//  ChatBubble.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct ChatBubble: View{
    
    //MARK: - Var
    var message: Message
    
    //MARK: - MainBody
    var body: some View{
        HStack{
            if !message.isFromCurrentUser{
                Spacer()
            }
            
            Text(message.text)
                .padding()
                .background(
                    message.isFromCurrentUser ?  Color(UIColor.systemGray6) : Color.blue
                )
                .foregroundColor(message.isFromCurrentUser ?  .black : .white )
                .clipShape(BubbleShape(isFromCurrentUser: message.isFromCurrentUser))
                .padding()
            
            if message.isFromCurrentUser{
                Spacer()
            }
        }
    }
}

//struct ChatBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatBubble(message: MOCK_MESSAGE[0])
//    }
//
//}
