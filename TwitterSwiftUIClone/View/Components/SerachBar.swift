//
//  SearchBar.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct SearchBar: View {
    
    //MARK: - Var
    @Binding var searchString: String
    
    var body: some View {
        HStack{
            
            TextField("Search...", text: $searchString)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        }
        .padding(.horizontal, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchString: .constant("Search..."))
    }
}
