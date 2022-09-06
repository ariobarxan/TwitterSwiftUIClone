//
//  FrameViewModifier.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/23/22.
//

import protocol SwiftUI.View
import struct SwiftUI.CGFloat
import protocol SwiftUI.ViewModifier
import struct SwiftUI.Alignment

struct FrameViewModifier: ViewModifier{
    
    let size: CGFloat
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size, alignment: alignment)
    }
}
