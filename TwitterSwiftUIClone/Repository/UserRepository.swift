//
//  UserRepository.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/29/22.
//

import Foundation

protocol UserRepositoryProtocol{
    func retrieveUser(with uid: String, completion: @escaping (_ user: User) -> ())
    
    func retreiveUsers(completion: @escaping (_ users: [User]) -> ())
    
    func retrieveUserStats(userID: String, completion: @escaping(_ userStats: UserStats) -> ())
    
    
}

final class UserRepository: UserRepositoryProtocol{
    
    private var userAPIService: UserAPIServiceProtocol
    
    private var users: [User]
    
    init(APIService: UserAPIServiceProtocol = UserAPIService(), users: [User] = [User]()){
        self.userAPIService = APIService
        self.users      = users
    }
    
    func retrieveUser(with uid: String, completion: @escaping (_ user: User) -> ()) {
        userAPIService.fetch(userID: uid) { response, userDictionaryData in
            guard response == .successful else {return}
            
            let user = User(dictionary: userDictionaryData)
            
            completion(user)
        }
    }
    
    func retreiveUsers(completion: @escaping (_ users: [User]) -> ()){
        userAPIService.fetchUsers { usersQuerySnapshotDocument in
            self.users = usersQuerySnapshotDocument.map({
                User(dictionary: $0.data())
            })
            completion(self.users)
        }
    }
    
    func retrieveUserStats(userID: String, completion: @escaping(_ userStats: UserStats) -> ()){
        userAPIService.fetchUserStats(userID: userID) { followingCount, followerCount in
            let userStats = UserStats(following: followingCount, followers: followerCount)
            
            completion(userStats)
        }
    }
}
