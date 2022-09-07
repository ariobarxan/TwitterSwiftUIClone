//
//  TextArea.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/25/22.
//

import SwiftUI

struct TextArea: View {
    //MARK: - Var
    @Binding var text: String
    let placeHolder: String
    
    //MARK: - Initializer
    init(_ placeholder: String, text: Binding<String>){
        self._text        = text
        self.placeHolder = placeholder
        
        UITextView.appearance().backgroundColor = .clear
    }
    //MARK: - MainBody
    var body: some View {
        ZStack(alignment: .topLeading){
            if text.isEmpty{
                placeholderText
            }
            
            TextEditor(text: $text)
                .padding(4)
            
        }
        .font(.body)
    }
}

struct TextArea_Previews: PreviewProvider {
    static var previews: some View {
        TextArea("Placeholder..." , text: .constant(""))
    }
}

extension TextArea{
    private var placeholderText: some View {
        Text(placeHolder)
            .foregroundColor(Color(UIColor.placeholderText))
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
    }
}
