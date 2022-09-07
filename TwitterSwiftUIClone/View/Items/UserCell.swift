//
//  UserCell.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI
import Kingfisher


struct UserCell: View {
    
    //MARK: - Var
    private let size: CGFloat = 56
    let user: User
    
    //MARK: - MainBody
    var body: some View {
        HStack{
           KFImage(URL(string: user.profileImageURL ?? ""))
           // Image("batman")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(size: size)
                .cornerRadius(size / 2)
            
            VStack(alignment: .leading, spacing: 4){
                Text(user.username)
                //Text("@batman")
                    .fontWeight(.semibold)
                
                Text(user.fullname)
                //  Text("Bruce Wayne")
                
            }
            .font(.system(size: 14))
            
        }
        .foregroundColor(.black)
    }
}

//struct UserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCell()
//    }
//}

extension UserCell{
    //add name
    //add username
    //add image
}
