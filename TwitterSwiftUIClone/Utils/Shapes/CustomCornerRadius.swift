//
//  CustomCornerRadius.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct CustomCornerRadius: Shape{
    var radii: CGFloat
    var corners: UIRectCorner = .allCorners
    
    
    func path(in rect: CGRect) -> Path {
        Path(
            UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radii, height: radii)
            ).cgPath
        )
    }
}
