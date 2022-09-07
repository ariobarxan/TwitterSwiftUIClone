//
//  CustomAuthenticationField.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/25/22.
//

import SwiftUI

struct CustomAuthenticationField: View {
    
    @Binding var text: String
    var placeholder:   String
    var image:         String
    
    
    //MARK: - MainBody
    var body: some View {
       TextField("", text: $text)
            .modifier(AuthenticationTextFieldViewModifier(text: $text, placeholderString: placeholder, leadingPaddingValue: 40, imageSystemName: image))
    }
}

struct CustomAuthenticationField_Previews: PreviewProvider {
    static var previews: some View {
        CustomAuthenticationField(text: .constant(""), placeholder: "Email", image: "envelope")
    }
}
