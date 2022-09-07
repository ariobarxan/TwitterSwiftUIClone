//
//  NewMessageView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct NewMessageView: View {
    //MARK: - Var
    @Binding var isShowingNewMessages: Bool
    @Binding var user: User?
    @StateObject private var viewModel = SearchViewModel(config: .newMessage)
    
    //MARK: - MainBody
    var body: some View {
        ScrollView{
            
            SearchBar(searchString: $viewModel.searchText)
                .padding()
            
            VStack{
                ForEach(viewModel.searchText.isEmpty ?  viewModel.users : viewModel.filteredUsers()){ user in
                    HStack{
                        
                        Button(action: {
                            self.isShowingNewMessages.toggle()
                            self.user = user
                            
                        }) {
                            UserCell(user: user)
                        }
                        
                        Spacer()
                    }
                    Divider()
                }
            }
            .padding(.leading)
          
        }
        .onAppear{
            viewModel.updateUsers()
        }
    }
}

//struct NewMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewMessageView(isShowingNewMessages: .constant(true))
//    }
//}
