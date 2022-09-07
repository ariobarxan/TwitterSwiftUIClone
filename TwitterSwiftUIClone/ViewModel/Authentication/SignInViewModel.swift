//
//  SignInViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/28/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

final class SignInViewModel: ObservableObject{
    
    @Published var email    = ""
    @Published var password = ""
    @Published var userSeession: Firebase.User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: User?
    
    private let repository: AuthUserRepositoryProtocol
    
    init(repository: AuthUserRepositoryProtocol = AuthUserRepository() ){
        self.repository   = repository
        self.userSeession = Auth.auth().currentUser
    }
    
    func signInTheUser(){
        
        guard email != "" && password != "" else{
            print("email and password are empty")
            return
        }
        
        self.repository.logInUser(withEmail: email, password: password) { firebaseUser in
            self.userSeession = firebaseUser
            if let usersession = self.userSeession {
                self.repository.retrieveCurentUser(withUID: usersession.uid) { user in
                    self.user = user
                    self.email    = ""
                    self.password = ""
                }
            }
        }
    }
    
    func fetchUser(){
        guard  let uid = userSeession?.uid else { return }
        
        repository.retrieveCurentUser(withUID: uid) { user in
            self.user = user
            
        }
    }
    
    
    ///Temporary
    func signOut(){
        userSeession = nil
        user         = nil
        try? Auth.auth().signOut()
    }
    
}
//TODO: - Implement a waitng process so after the user requests for signing up the shows it
//Handling the error

//TODO: - Examine should we define one Signleton for auth?? so then we don't need create this much of environment objects, instead we can have only one environment object and that would be the singleton

