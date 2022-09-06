//
//  View.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/23/22.
//

import SwiftUI

extension View{
    
    
    
    
    public func frame(size: CGFloat, alignment: Alignment = .center) -> some View{
        modifier(FrameViewModifier(size: size, alignment: alignment))
    }
    
    public func frame(width: CGFloat, height: CGFloat) -> some View{
        self.frame(width: width, height: height, alignment: .center)
    }
    
    
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

