//
//  SignUpViewModel.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/26/22.
//

import SwiftUI
import Firebase

final class SignUpViewModel: ObservableObject{
    
    @Published var fullName = ""
    @Published var email    = ""
    @Published var passwrod = ""
    @Published var username = ""
    @Published var image: UIImage?
    @Published var userSession: Firebase.User?
    
    private let repository: AuthUserRepositoryProtocol
    
    init(repository: AuthUserRepositoryProtocol = AuthUserRepository()){
        self.repository = repository
    }
    
    func signUpTheUser(){
        
        guard let user = createAuthUser() else {
            print("user was not created")
            return
        }
        
        self.repository.registerUser(user){ response, fireBaseUser in
            guard response == .successful else {return}
            print("DEBUG: == \(response)")
            self.userSession = fireBaseUser
        }
        
        ///Create the AuthUser Object
        func createAuthUser() -> User? {
            
            guard fullName != "" && email != "" && passwrod != "" && username != "", let imageData = image else { return nil }
            
            
            
            
            
            
            if fullName != "" && email != "" && passwrod != "" && username != ""{
                let user = User(email: email,
                                password: passwrod,
                                userName: username,
                                fullName: fullName,
                                profileImage: imageData)
                return user
            }
            else {return nil}
            
            
        }
    }
    
    
}
//TODO: - Implement a waitng process so after the user requests for signing up the shows it
//Handling the error
