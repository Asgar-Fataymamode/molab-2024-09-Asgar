//
//  HeightPicker.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//

import SwiftUI

struct HeightPicker: View {
    @Binding var height: Double

    var body: some View {
        VStack {
            Text("Height (m)")
                .font(.headline)
            Text(String(format: "%.2f m", height))
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .onTapGesture {
                }
            Slider(value: $height, in: 1.20...2.50, step: 0.01) {
                Text("Height")
            }
            .padding(.horizontal)
        }
    }
}
