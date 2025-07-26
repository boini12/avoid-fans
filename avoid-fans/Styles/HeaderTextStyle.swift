//
//  HeaderTextStyle.swift
//  avoid-fans
//
//  Created by Ines Bohr on 25.07.25.
//

import SwiftUI

struct HeaderTextStyle : TextStyle {
    
    func body(content: Content) -> some View {
            content
            .font(.system(size: 30, weight: .black, design: .serif))
            .foregroundColor(Color("headerColor"))
        }
}
