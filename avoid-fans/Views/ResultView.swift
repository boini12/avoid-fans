//
//  ResultView.swift
//  avoid-fans
//
//  Created by Ines Bohr on 23.07.25.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: ResultViewModel = ResultViewModel()
    let journey: Journey
    
    var body: some View {
        VStack {
          if viewModel.resultText.isEmpty {
              Text("Checking for clashes...")
          } else {
              Text(viewModel.resultText)
          }
      }
      .onAppear {
          Task {
              await viewModel.checkForClash(journey: journey)
          }
      }
    }
       
}
