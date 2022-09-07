//
//  SearchViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/30/22.
//

import SwiftUI

final class SearchViewModel: ObservableObject{
    
    @Published var users      = [User]()
    @Published var searchText = ""
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = UserRepository()){
        self.userRepository = userRepository
    }
    
    func updateUsers(){
        userRepository.retreiveUsers(){ users in
            self.users = users
        }
    }
    
    func filteredUsers() -> [User]{
        let queryString = searchText.lowercased()
        
        return users.filter({$0.fullname.lowercased().contains(queryString) || $0.username.lowercased().contains(queryString)})
    }
}

//TODO: - Show nothing or mixture of users in the search View and then filter them
//TODO: - Use a time limitter for seraching so not every second a user types we send query

