//
//  ChatBubble.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct ChatBubble: View{
    
    //MARK: - Var
    var message: MockMessage
    
    //MARK: - MainBody
    var body: some View{
        HStack{
            if !message.isCurrentUser{
                Spacer()
            }
            
            Text(message.messageText)
                .padding()
                .background(
                    message.isCurrentUser ?  Color(UIColor.systemGray6) : Color.blue
                )
                .foregroundColor(message.isCurrentUser ?  .black : .white )
                .clipShape(BubbleShape(isFromCurrentUser: message.isCurrentUser))
                .padding(.horizontal)
            
            if message.isCurrentUser{
                Spacer()
            }
        }
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(message: MOCK_MESSAGE[0])
    }

}
