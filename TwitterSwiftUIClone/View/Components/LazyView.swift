//
//  LazyView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 9/1/22.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping() -> Content ){
        self.build = build
            
    }
    
    var body: some View{
        build()
    }

}

