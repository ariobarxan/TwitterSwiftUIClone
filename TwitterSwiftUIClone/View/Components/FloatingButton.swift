//
//  FloatingButton.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct FloatingButton: View {
    //MARK: - Var
    var imageName: String
    var isSystemName: Bool?
    var action: action
    
    
    
    //MARK: - MainBody
    var body: some View {
        
        if let _ = isSystemName{
            buttonWithSystemImage
        }else{
            buttonWithAssetImage
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(imageName: icons.tweet.rawValue, action: {})
    }
}

extension FloatingButton {
    //MARK: - Views
    private var buttonWithAssetImage:  some View {
        Button(action:{
            action()
        }){
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .frame(size: 32)
                .padding()
            
        }
        .background(Color(UIColor.systemBlue))
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding()
    }
    private var buttonWithSystemImage: some View {
        Button(action:{
            action()
        }){
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(size: 32)
                .padding()
            
        }
        .background(Color(UIColor.systemBlue))
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding()
    }
}
