//
//  AuthenticationTextField.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/25/22.
//

import SwiftUI

struct EmailField: View {
    
    //MARK: - Var
    @Binding var text: String
    private let leadingPaddingValue: CGFloat = 40
    
    //MARK: - MainBody
    var body: some View {
        TextField("", text: $text)
            .keyboardType(.emailAddress)
            .modifier(
                AuthenticationTextFieldViewModifier(
                    text: $text,
                    placeholderString: "Email",
                    leadingPaddingValue: leadingPaddingValue,
                    imageSystemName: "envelope"))
            
    }
}

struct EmailField_Previews: PreviewProvider {
    static var previews: some View {
        EmailField(text: .constant(""))
    }
}
