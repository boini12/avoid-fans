//
//  ResultView.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import SwiftUI

struct ResultView: View {
    var fansAvoided : Bool
    
    var body: some View {
        if(fansAvoided == true){
            Text("No fans detected")
        }else{
            Text("We recommend to coose another date for travelling")
        }
    }
}


 struct ResultView_Previews: PreviewProvider {
     static var previews: some View {
         ResultView(fansAvoided: false)
     }
 }

