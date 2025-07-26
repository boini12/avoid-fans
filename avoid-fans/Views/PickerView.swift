//
//  Picker.swift
//  avoid-fans
//
//  Created by Ines Bohr on 18.07.25.
//
import SwiftUI

struct PickerView: View {
    let stations: [String]
    let labelText: String
    @Binding var selectedOptionIndex: Int

    var body: some View {
        HStack {
            Text(labelText)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker("Select a station", selection: $selectedOptionIndex) {
                    ForEach(0..<stations.count, id: \.self) { index in
                            Text(stations[index])
                        }
                }
                .pickerStyle(.menu)
                .accentColor(.white)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color("primaryColor"), lineWidth: 1))
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        let stations = ["Hamburg", "Munich", "Cologne", "Berlin"]
        let labelText = "Origin"
        @State var index = 0;
        PickerView(stations: stations, labelText: labelText, selectedOptionIndex: $index)
    }
}
