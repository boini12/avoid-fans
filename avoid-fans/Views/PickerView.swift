//
//  Picker.swift
//  avoid-fans
//
//  Created by Ines Bohr on 18.07.25.
//
import SwiftUI

struct PickerView: View {
    let stations: [String]
    @Binding var selectedOptionIndex: Int

    var body: some View {
            VStack {
                Picker("Select a station", selection: $selectedOptionIndex) {
                    ForEach(0..<stations.count, id: \.self) { index in
                            Text(stations[index]).tag(index)
                        }
                }
            }
            .frame(width: 150, height: 30)
            .background(Color(UIColor.lightGray).opacity(0.4))
            .cornerRadius(20)
        }
    }

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        var stations = ["Hamburg", "Munich", "Cologne", "Berlin"]
        @State var index = 0;
        PickerView(stations: stations, selectedOptionIndex: $index)
    }
}
