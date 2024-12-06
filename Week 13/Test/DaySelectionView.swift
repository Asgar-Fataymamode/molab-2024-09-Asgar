//
//  DaySelection.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//

import SwiftUI

struct DaySelectionView: View {
    @Binding var selectedDays: [String]
    let daysOfWeek: [String]

    var body: some View {
        VStack {
            Text("Preferred Training Days")
                .font(.headline)
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Button(action: {
                        toggleDaySelection(day: day)
                    }) {
                        Text(day.prefix(1)) 
                            .padding()
                            .background(selectedDays.contains(day) ? Color.blue : Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }

    private func toggleDaySelection(day: String) {
        if selectedDays.contains(day) {
            selectedDays.removeAll { $0 == day }
        } else {
            selectedDays.append(day)
        }
    }
}

