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
                .foregroundColor(Color(red: 0.968, green: 0.968, blue: 0.968))
        }
}
