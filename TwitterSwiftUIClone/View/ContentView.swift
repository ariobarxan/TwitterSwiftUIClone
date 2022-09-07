//
//  ContentView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 1/1/21.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Var
    @EnvironmentObject private var viewModel: SignInViewModel
    
    //MARK: - MainBody
    var body: some View {
        Group{
            if viewModel.userSeession != nil{
                MainTabView()
                    
            }else{
                SigninView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
