//
//  ConversationCell.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    
    //MARK: - Var
    private let size: CGFloat = 56
    let message: Message
    
    //MARK: - MainBody
    var body: some View {
        VStack {
            HStack{
                KFImage(URL(string: message.user.profileImageURL ?? ""))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(size: size)
                    .cornerRadius(size / 2)
                
               
                
                VStack(alignment: .leading, spacing: 4){
                    Text(message.user.username)
                        .fontWeight(.semibold)
                    
                    Text(message.text)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        
                    
                }
                .font(.system(size: 14))
                .padding(.trailing)
                
                Spacer(minLength: 0)
            }
            
            Divider()
        }
        .padding(.horizontal)
        .foregroundColor(.black)
    }
}

//struct ConversationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationCell()
//    }
//}

extension ConversationCell{
    ///add image
    ///add last message
    ///add username
}
