//
//  ContentView.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import SwiftUI

struct ContentView: View {
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    
    var body: some View {
        VStack {
            DatePicker(selection: $startDate, in: ...Date.now, displayedComponents: .date){
                Text("Select a start date")
            }
            
            DatePicker(selection: $endDate, in: ...Date.now, displayedComponents: .date){
                Text("Select a end date")
            }
            
            Text("Date is \(startDate.formatted(date: .long, time: .omitted))")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
