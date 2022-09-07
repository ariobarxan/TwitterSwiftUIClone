//
//  NewMessageView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct NewMessageView: View {
    //MARK: - Var
    @State private var searchText = ""
    @Binding var isShowingNewMessages: Bool
        
    //MARK: - MainBody
    var body: some View {
        ScrollView{
            
            SearchBar(searchString: $searchText)
                .padding()
            
            VStack{
                ForEach(0..<10){ _ in
                  
                    HStack{
//                        UserCell()
//                            .onTapGesture {
//                                isShowingNewMessages.toggle()
//                            }
//
                        Spacer()
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding(.leading)
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(isShowingNewMessages: .constant(true))
    }
}
