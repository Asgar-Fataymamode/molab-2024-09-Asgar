//
//  PickerView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//

import SwiftUI

struct PickerView: View {
    let title: String
    let options: [String]
    @Binding var selection: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}
