//
//  ConversationCell.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct ConversationCell: View {
    
    //MARK: - Var
    private var size: CGFloat = 56
    
    //MARK: - MainBody
    var body: some View {
        VStack {
            HStack{
                Image("batman")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(size: size)
                    .cornerRadius(size / 2)
                
                VStack(alignment: .leading, spacing: 4){
                    Text("batman")
                        .fontWeight(.semibold)
                    
                    Text("Longer Message for showing the last message sent from the user, and the other thig that I want to test is that I don't want to show more than 2 lines")
                        .lineLimit(2)
                        
                    
                }
                .font(.system(size: 14))
                .padding(.trailing)
                
            }
            
            Divider()
        }
        .foregroundColor(.black)
    }
}

struct ConversationCell_Previews: PreviewProvider {
    static var previews: some View {
        ConversationCell()
    }
}

extension ConversationCell{
    ///add image
    ///add last message
    ///add username
}
