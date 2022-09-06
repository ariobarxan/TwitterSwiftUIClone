//
//  BubbleShape.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct BubbleShape: Shape {
    
    //MARK: - Var
    var isFromCurrentUser: Bool
    var radii: CGFloat = 16
    
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight, isFromCurrentUser ?  .bottomRight : .bottomLeft],
            cornerRadii: CGSize(width: radii, height: radii)).cgPath
        
        return Path(path)
    }
}
