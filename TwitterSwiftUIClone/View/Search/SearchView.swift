//
//  SearchView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct SearchView: View {
    
    //MARK: - Var
    @StateObject private var viewModel = SearchViewModel(config: .search)
    
    //MARK: - MainBody
    var body: some View {
        ScrollView{
                
            SearchBar(searchString: $viewModel.searchText)
                .padding()
                
            VStack{
                ForEach(viewModel.searchText.isEmpty ? viewModel.users : viewModel.filteredUsers()){ user in
                      
                    HStack{
                        NavigationLink(destination:
                            LazyView(
                                UserProfileView()
                                .environmentObject(UserProfileViewModel(user: user))
                            )
                        ){
                            UserCell(user: user)
                        }
                        
                            
                        Spacer()
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding(.leading)
        }
        .onAppear{
            viewModel.updateUsers()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SearchView()
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
