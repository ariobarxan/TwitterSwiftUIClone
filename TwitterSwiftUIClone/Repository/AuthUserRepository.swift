//
//  AuthUserRepository.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/26/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

protocol AuthUserRepositoryProtocol{
    
    func registerUser(_ user: User, completion: @escaping (_ response: APIResult.Auth, _ firebaseUser: Firebase.User) -> ())
    func logInUser(withEmail email: String, password pass: String, completion: @escaping (_ firebaseUser: Firebase.User) -> ())
    func retrieveCurentUser(withUID uid: String, completion: @escaping (_ user: User) -> ())
}

final class AuthUserRepository: AuthUserRepositoryProtocol{
        
    private var apiSrvice: AuthUserAPIServiceProtocol
    
    init(APIService: AuthUserAPIServiceProtocol = AuthUserAPIService()){
        self.apiSrvice = APIService
    }

    
    func registerUser(_ user: User, completion: @escaping (_ response: APIResult.Auth, _ firebaseUser: Firebase.User) -> ()) {
        apiSrvice.registerUser(user){ response, authUser in
            completion(response, authUser)
        }
    }
    
    func logInUser(withEmail email: String, password pass: String,  completion: @escaping (Firebase.User) -> ()) {
        apiSrvice.logIn(withEmail: email, password: pass) { apiResult, authResult  in
            guard apiResult == .successful else {return}
            completion(authResult.user)
        }
    }
    
    func retrieveCurentUser(withUID uid: String, completion: @escaping (_ user: User) -> ()){
        let repo = UserRepository()
        
        repo.retrieveUser(with: uid) { user in
            completion(user)
        }
        
        
    }
}

//TODO: - Refactor error handling
//NOTE: - We can have just one ViewModel same as Repository for Authentication and and pros would be that we can have one environment object of  it, that it can be used every where and view control can be done all in one place...
