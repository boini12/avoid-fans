//
//  ButtonStyle.swift
//  avoid-fans
//
//  Created by Ines Bohr on 25.07.25.
//

import SwiftUI

struct PrimaryButtonStyle : ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .buttonStyle(.borderedProminent)
            .background(Color.accentColor)
            .bold()
            .clipShape(Capsule(style: .continuous))
            .controlSize(.mini)
            .foregroundStyle(.white)
            .animation(.smooth, value:configuration.isPressed)
    }
    
}
