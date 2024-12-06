//
//  WidthPicker.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//

import SwiftUI

struct WeightPicker: View {
    @Binding var weight: Int

    var body: some View {
        VStack {
            Text("Weight (kg)")
                .font(.headline)
            Text("\(weight) kg")
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            Slider(value: Binding(get: {
                Double(weight)
            }, set: { newValue in
                weight = Int(newValue)
            }), in: 40...150, step: 1) {
                Text("Weight")
            }
            .padding(.horizontal)
        }
    }
}
