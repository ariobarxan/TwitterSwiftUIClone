//
//  Authentication Button.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/25/22.
//

import SwiftUI

struct AuthenticationButton: View {
    
    //MARK: - Var
    var action: action
    var text: String
    
    //MARK: - MainBody
    var body: some View {
        Button(action: {
            action()
        }){
            Text(text)
                .font(.headline)
                .foregroundColor(.blue)
                .frame(width: 360, height: 50)
                .background(Color.white)
                .clipShape(Capsule())
                .padding()
        }
    }
}

struct AuthenticationButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationButton(action: {}, text: "Sig In")
    }
}


