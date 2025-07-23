//
//  ResultView.swift
//  avoid-fans
//
//  Created by Ines Bohr on 23.07.25.
//

import SwiftUI

struct ResultView: View {
    @State var result: String = ""
    
    var body: some View {
        
        if (result == "false") {
            VStack {
                Text("✅")
            }
        }else {
            VStack {
                Text("❌")
            }
        }
    }
}
