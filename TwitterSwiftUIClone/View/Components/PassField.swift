//
//  PassField.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/25/22.
//
import SwiftUI

struct PassField: View {
    
    //MARK: - Var
    @Binding var password: String
    @State private var isSecured = true
    private let leadingPaddingValue: CGFloat = 40
   
    
    //MARK: - MainBody
    var body: some View {
        if isSecured{
            secureField
        }else{
            showPasswordField
        }
    }
}

struct PassField_Previews: PreviewProvider {
    static var previews: some View {
        PassField(password: .constant(""))
    }
}

extension PassField{
    //MARK: - Var
    private var secureField: some View{
        SecureField("", text: $password)
            .modifier(
                AuthenticationTextFieldViewModifier(text: $password, placeholderString: "password", leadingPaddingValue: leadingPaddingValue, imageSystemName: "eye"){
                    isSecured = false
                }
            )
    }
    private var showPasswordField: some View {
        TextField("", text: $password)
            .modifier(
                AuthenticationTextFieldViewModifier(text: $password, placeholderString: "password", leadingPaddingValue: leadingPaddingValue, imageSystemName: "eye.slash"){
                    isSecured = true
                }
            )
    }
}

//FIXME: - Hide&show
///Scenario:
///Whenever you press show image it'll show you the password and you can continue adding character to your
///password string but as soon as you press the hide image you can not add characters to your password anymore
