//
//  AuthUserAPIService.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/26/22.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth

protocol AuthUserAPIServiceProtocol{
    var apiResponse: APIResult.Auth{ get }
    
    func registerUser(_ user: User, completion: @escaping (APIResult.Auth, Firebase.User) ->())
    
    func logIn(withEmail email: String, password pass: String, completion: @escaping (APIResult.Auth , AuthDataResult) -> Void)
}

final class AuthUserAPIService: AuthUserAPIServiceProtocol{

    //MARK: - Var
    var apiResponse: APIResult.Auth = APIResult.Auth.noResult
    
    
    //MARK: - Functions
    func registerUser(_ user: User, completion: @escaping (APIResult.Auth, Firebase.User) ->()) {

        guard let image = user.profileImage else {return}
        ///Compressing Image Data
        guard let imageData = image.jpegData(compressionQuality: 0.3) else {
            self.apiResponse = .imageCompressError
            return
        }
        
        ///Creating a unique file name for the image
        let fileName = NSUUID().uuidString

        sotreTheProfileImageAndGetTheURL(fileName: fileName, imageData: imageData) { userProfileImageURL in
            guard let password = user.pass else {return}
            createTheUser(with: user.email, password: password, profileImageURL: userProfileImageURL) { authUser, imageURL, fireBaseUser in
                storeTheUserOnFireStore(user: authUser, imageURL: imageURL, resultUser: fireBaseUser) { apiResult, firebaseUser in
                    completion(apiResult, fireBaseUser)
                }
            }
        }
        
        
        ///Nested Functions ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        
        func sotreTheProfileImageAndGetTheURL(fileName: String, imageData: Data, completion: @escaping (_ userProfileImageURL: String) -> ()){
            
            ///Creating a reference to the storage where the image is going to be saved
            let storageReference = Storage.storage().reference().child(fileName)
            
            storageReference.putData(imageData, metadata: nil) { _, error in
                if let _ = error {
                    self.apiResponse = .imageStroingError
                    return
                }
                
                storageReference.downloadURL { url, error in
                    if let _ = error{
                        self.apiResponse = .gettingImageURL
                        return
                    }
                    
                    guard let profileImageURL = url?.absoluteString else {
                        self.apiResponse = .creatingImageURL
                        return
                    }
                    
                    completion(profileImageURL)
                }
                
            }
        }
        
        func createTheUser(with email: String, password: String, profileImageURL: String, completion: @escaping (_ authUser: User, _ imageURL: String, _ currentUser: Firebase.User) -> ()){

            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let _ = error{
                    //print("DEBUG - Error FROM AuthUserAPIService: \(err.localizedDescription)")
                    self.apiResponse = .error
                    return
                }


                guard let resultUser = authResult?.user else {
                    self.apiResponse = .getUser
                    return
                }

                completion(user, profileImageURL, resultUser)
            }
        }
        
        func storeTheUserOnFireStore(user: User, imageURL profileImageURL: String, resultUser currentUser: Firebase.User, completion: @escaping (_ apiResult: APIResult.Auth, _ authUser: Firebase.User) -> ()){
           
            let uid = currentUser.uid
            ///Creating data structure so the  user data can be stored on the firestore
            let userDataDictionary = ["email": user.email,
                                      "username": user.username.lowercased(),
                                      "fullname": user.fullname,
                                      "profileImageUrl": profileImageURL,
                                      "uid": uid]
            
            ///Storing the user data on the firestore Collection
            COLLECTION_USERS.document(uid).setData(userDataDictionary) { error in
                if let _ = error{
                    self.apiResponse = .fireStoreStoring
                    return
                }
                self.apiResponse = .successful
                
                completion(self.apiResponse, currentUser)
            }
        }
    }
    
    func logIn(withEmail email: String, password pass: String, completion: @escaping (APIResult.Auth, AuthDataResult) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { authDataResult, error in
            if let err = error{
                print("Debug: Error: \(err.localizedDescription)")
                self.apiResponse = .userNamePassError
                return
            }
            guard let authResult = authDataResult else{return}
            print("DeBug: Logged in successfully")
            completion(.successful, authResult)
        }
        
        
        
        func createUserFromRetreivedData(){
            
        }
    }
}

//TODO: - Implement and Error ecosystem





