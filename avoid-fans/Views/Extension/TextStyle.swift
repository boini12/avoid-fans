//
//  HeaderTextStyle.swift
//  avoid-fans
//
//  Created by Ines Bohr on 25.07.25.
//

import SwiftUI

extension Text {
    func textStyle<T: TextStyle>(_ style: T) -> some View {
           modifier(style)
       }
}


