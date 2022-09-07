//
//  UserSearchView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct UserSearchView: View {
    
    //MARK: - Var
    @Binding var searchText: String
    var tapGestureAction: action
    
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
//                                tapGestureAction()
//                            }
                        Spacer()
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding(.leading)
        }
    }
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView(searchText: .constant(""), tapGestureAction: {})
    }
}

//Use it and embed it with in both Searchview and Message Sheet
