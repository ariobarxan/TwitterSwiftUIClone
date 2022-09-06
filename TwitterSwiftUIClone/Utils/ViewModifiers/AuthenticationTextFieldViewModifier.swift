//
//  AuthenticationTextFieldViewModifier.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/25/22.
//

import  SwiftUI


struct AuthenticationTextFieldViewModifier: ViewModifier{
    
    @Binding var text: String
    var placeholderString: String
    var leadingPaddingValue: CGFloat
    var imageSystemName: String
    var action: action?
    
    func body(content: Content) -> some View {
        content
            .placeholder(when: text.isEmpty, placeholder: {
                Text(placeholderString).foregroundColor(.init(white: 1, opacity: 0.87))
            })
            
            .padding(.leading, leadingPaddingValue)
            .padding()
            .background(Color(.init(white: 1, alpha: 0.15)))
            .overlay(
                HStack{
                    Image(systemName: imageSystemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color(.init(white: 1, alpha: 0.87)))
                        .frame(size: 25)
                        .foregroundColor(.white)
                        .padding(.leading, leadingPaddingValue / 2)
                        .onTapGesture {
                            if let action = action{
                                action()
                            }
                        }
                    
                    Spacer()
                }
            )
            .foregroundColor(.white)
            
            .cornerRadius(10)
    }
    
}
//.background(Color(.init(white: 1, alpha: 0.15)))
