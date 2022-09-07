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
    private let config: SearchViewModelConfiguration
    
    init(config: SearchViewModelConfiguration ,userRepository: UserRepositoryProtocol = UserRepository()){
        self.userRepository = userRepository
        self.config         = config
        
        updateUsers()
    }
    
    func updateUsers(){
        userRepository.retreiveUsers(){ users in
            switch self.config{
                case .newMessage:
                    self.users = users.filter({!$0.isCurrentUser})
                case.search:
                    self.users = users
            }
        }
    }
    
    func filteredUsers() -> [User]{
        let queryString = searchText.lowercased()
    
        return users.filter({$0.fullname.lowercased().contains(queryString) || $0.username.lowercased().contains(queryString)})
    }
}

//TODO: - Show nothing or mixture of users in the search View and then filter them
//TODO: - Use a time limitter for seraching so not every second a user types we send query

enum SearchViewModelConfiguration{
    case search
    case newMessage
}
