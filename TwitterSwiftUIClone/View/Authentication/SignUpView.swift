//
//  SignUpView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/25/22.
//

import SwiftUI

struct SignUpView: View {
    
    //MARK: - Var
    @StateObject private var viewModel = SignUpViewModel()
    @State private var image: Image?
    @State private var selectedUIImage: UIImage?
    @State private var shouldShowImagePicker = false
    @Environment(\.dismiss) private var dismissView
    
    //MARK: - MainBody
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                ContentView()
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(SignInViewModel())
            }else{
                ZStack{
                    backGroundView
                    
                    VStack{
                        profileImage
                        
                        
                        VStack(spacing: 20){
                            
                            CustomAuthenticationField(text: $viewModel.fullName, placeholder: "Full Name", image: "person")
                            
                            EmailField(text: $viewModel.email)
                            
                            CustomAuthenticationField(text: $viewModel.username, placeholder: "User Name", image: "person")
                                
                            
                            
                            PassField(password: $viewModel.passwrod)
                            
                            
                        }
                        .padding()
                        .padding(.top)
                        
                        AuthenticationButton(action: {
                            viewModel.signUpTheUser()
                        }, text: "Sign Up")
                        Spacer()
                        
                        signinButton
                            .padding(.bottom, 40)
                    }
                    .navigationBarHidden(true)
                }
                .sheet(isPresented: $shouldShowImagePicker,
                       onDismiss: loadProfileImage){
                    ImagePicker(image: $selectedUIImage)
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

extension SignUpView{
    
    //MARK: - View
    private var backGroundView: some View {
        Color.primaries.twitterBlue.rawValue.associatedColor.edgesIgnoringSafeArea(.all)
    }
    private var profileImage:   some View {
        Button(action:{
            shouldShowImagePicker = true
        }){

            if let image = image{
                image
                    .signUPImageViewModifier(isProfile: true)
            }else{
                Image(icons.addPhoto.rawValue)
                    .signUPImageViewModifier(isProfile: false)
            }
            
            
        }
    }
    private var signinButton:   some View {
        Button(action: {
            self.dismissView()
        }){
            HStack{
                Text("Already have an account?")
                    .font(.system(size: 14))
                
                Text("Sign In")
                    .font(.system(size: 14, weight: .semibold))
                
            }
            .foregroundColor(.white)
        }
    }
    
    
    //MARK: - Functions
    private func loadProfileImage(){
        guard let selcetedImage = selectedUIImage else {return}
        viewModel.image         = selcetedImage
        image                   = Image(uiImage: selcetedImage)
    }
}

extension Image{
    fileprivate func signUPImageViewModifier(isProfile: Bool) -> some View{
        self
            .resizable()
            .renderingMode(isProfile ? .original : .template)
            .foregroundColor(isProfile ? .clear : .white)
            .scaledToFill()
            .frame(size: 140)
            .clipShape(Circle())
            .padding(.top, 88)
            .padding(.bottom, 8)
    }
}

//TODO: - Search
///Does navigating from sign up to sign in and then from sign in to sign up create loop of views
///on presented each other?(with a navigation link)


//TODO: - Disable the sign up button after user request for it so one can't send more than one request and try to show the process if neded
