//
//  LoginView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/25/22.
//

import SwiftUI

struct SigninView: View {
    
    //MARK: - Var
    @EnvironmentObject private var viewModel: SignInViewModel
    
    //MARK: - MainBody
    var body: some View {
        ZStack {
            backGroundView
            
            VStack {
                logoImage
                
                VStack(spacing: 20){
                    EmailField(text: $viewModel.email)
                    
                    
                    PassField(password: $viewModel.password)
                }
                .padding()
                .padding(.top)
                
                forgetPassword
                
                AuthenticationButton(action: {
                    viewModel.signInTheUser()
                }, text: "Sign In")
                
                Spacer()
                
                signupButton
            }
            .navigationBarHidden(true)
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}

extension SigninView{
    //MARK: - View
    private var backGroundView: some View {
        Color.primaries.twitterBlue.rawValue.associatedColor.edgesIgnoringSafeArea(.all)
    }
    private var logoImage:      some View {
        Image(logos.twitterLogo.rawValue)
            .resizable()
            .scaledToFill()
            .frame(width: 220, height: 100)
            .padding(.top ,88)
    }
    private var forgetPassword: some View {
        HStack{
            Spacer()
            
            Button(action:{}){
                Text("Forget Password?")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 16)
                    .padding(.trailing, 32)
            }
        }
    }
    private var signupButton:   some View {
        NavigationLink(destination: SignUpView()) {
            HStack{
                Text("Don't have an account?")
                    .font(.system(size: 14))
                
                Text("Sign Up")
                    .font(.system(size: 14, weight: .semibold))
                
            }
            .foregroundColor(.white)
            .padding(.bottom, 40)
        }

    }
    
}
