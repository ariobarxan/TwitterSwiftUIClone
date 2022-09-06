//
//  AppColors.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/25/22.
//

import Foundation
import struct SwiftUI.Color

struct AppColors: Equatable, ExpressibleByStringLiteral{
    
    //MARK: - Variables
    var associatedName:  String
    var associatedColor: Color{
        return Color("\(associatedName)")
    }
    
    //MARK: - Initializer
    init(stringLiteral value: StringLiteralType){
        associatedName = value
    }
    
}
