//
//  AddGoalView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//


import SwiftUI
import FirebaseAuth

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var goalName: String = ""
    @State private var initialProgress: Double = 0.0
    
    var addGoal: (Goal) -> Void

    var body: some View {
        Form {
            Section(header: Text("Goal Details")) {
                TextField("Goal Name", text: $goalName)

                VStack {
                    Text("Initial Progress: \(Int(initialProgress * 100))%")
                    Slider(value: $initialProgress, in: 0.0...1.0, step: 0.05)
                }
            }
            .padding()

            Button(action: {
                saveGoal()
            }) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(goalName.isEmpty ? Color.gray : Color.green)
                    .cornerRadius(10)
            }
            .disabled(goalName.isEmpty)
            .padding()

            Button(action: {
                dismiss()
            }) {
                Text("Back")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Add New Goal")
    }
    
    private func saveGoal() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let newGoal = Goal(
            id: UUID(),
            name: goalName,
            progress: initialProgress,
            isCompleted: false,
            completionDate: nil,
            userId: userId
        )
        addGoal(newGoal)
        dismiss()
    }
}

