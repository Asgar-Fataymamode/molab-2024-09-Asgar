//
//  AddGoalView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 21/11/2024.
//


//
//import SwiftUI
//
//struct AddGoalView: View {
//    @Environment(\.dismiss) var dismiss
//    @State private var goalName: String = ""
//    @State private var initialProgress: Double = 0.0
//    
//    var addGoal: (Goal) -> Void
//
//    var body: some View {
//        Form {
//            Section(header: Text("Goal Details")) {
//                TextField("Goal Name", text: $goalName)
//                
//                VStack {
//                    Text("Initial Progress: \(Int(initialProgress * 100))%")
//                    Slider(value: $initialProgress, in: 0.0...1.0, step: 0.05)
//                }
//            }
//            .padding()
//            
//            Button(action: {
//                saveGoal()
//            }) {
//                Text("Save")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(goalName.isEmpty ? Color.gray : Color.green)
//                    .cornerRadius(10)
//            }
//            .disabled(goalName.isEmpty)
//            .padding()
//        }
//        .navigationTitle("Add New Goal")
//        .toolbar {
//            ToolbarItem(placement: .cancellationAction) {
//                Button("Cancel") {
//                    dismiss()
//                }
//            }
//        }
//    }
//    
//    private func saveGoal() {
//        let newGoal = Goal(name: goalName, progress: initialProgress, isCompleted: false)
//        addGoal(newGoal)
//        dismiss() 
//    }
//}
