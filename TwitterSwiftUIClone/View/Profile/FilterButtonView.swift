//
//  FilterButtonView.swift
//  TwitterClone
//
//  Created by Amirreza Zarepour on 8/24/22.
//

import SwiftUI

struct FilterButtonView: View {
    
    //MARK: - Var
    @Binding var selectedFilter: TweetFilterOptions
    
    private let underlineWidth = DeviceAttributes.deviceWidth / CGFloat(TweetFilterOptions.allCases.count)
    private var padding: CGFloat{
        let rawValue = CGFloat(selectedFilter.rawValue)
        let count    = CGFloat(TweetFilterOptions.allCases.count)
        
        return ((DeviceAttributes.deviceWidth / count) * rawValue) + 16.0
    }
    
    
    
    //MARK: - MainBody
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                ForEach(TweetFilterOptions.allCases, id: \.self){ option in
                    
                    Button(action: {
                        self.selectedFilter = option
                    }){
                        Text(option.title)
                            .frame(width: underlineWidth - 8)
                            .minimumScaleFactor(0.6)
                    }
                }
            }
            
            Rectangle()
                .frame(width: underlineWidth - 32, height: 3, alignment: .center)
                .foregroundColor(.blue)
                .padding(.leading, padding)
                .animation(.spring(), value: padding)
            
        }
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView(selectedFilter: .constant(.tweets))
    }
}
