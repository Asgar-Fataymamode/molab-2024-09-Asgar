//
//  DaySelection.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//
//
//import SwiftUI
//
//struct DaySelectionView: View {
//    @Binding var selectedDays: [String]
//    let daysOfWeek: [String]
//
//    var body: some View {
//        VStack {
//            Text("Preferred Training Days")
//                .font(.headline)
//            HStack {
//                ForEach(daysOfWeek, id: \.self) { day in
//                    Button(action: {
//                        toggleDaySelection(day: day)
//                    }) {
//                        Text(day.prefix(1)) 
//                            .padding()
//                            .background(selectedDays.contains(day) ? Color.blue : Color.gray.opacity(0.3))
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//                }
//            }
//        }
//    }
//
//    private func toggleDaySelection(day: String) {
//        if selectedDays.contains(day) {
//            selectedDays.removeAll { $0 == day }
//        } else {
//            selectedDays.append(day)
//        }
//    }
//}




import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct DaySelectionView: View {
    @State private var selectedDays: [String] = [] // Local state for selected days
    private let db = Firestore.firestore()
    private let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        VStack {
            Text("Preferred Training Days")
                .font(.headline)

            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Button(action: {
                        toggleDaySelection(day: day)
                    }) {
                        Text(day.prefix(1)) // Show the first letter of the day
                            .padding()
                            .background(selectedDays.contains(day) ? Color.blue : Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }

            Button(action: saveSelectedDays) {
                Text("Save Training Days")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear(perform: fetchSelectedDays) // Fetch days from the database when the view appears
    }

    private func toggleDaySelection(day: String) {
        if selectedDays.contains(day) {
            selectedDays.removeAll { $0 == day }
        } else {
            selectedDays.append(day)
        }
    }

    private func saveSelectedDays() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        // Save selected days to Firestore
        db.collection("weeklyActivity").document(userId).setData([
            "trainedDays": daysOfWeek.map { selectedDays.contains($0) },
            "userId": userId
        ], merge: true) { error in
            if let error = error {
                print("Error saving training days: \(error.localizedDescription)")
            } else {
                print("Training days saved successfully.")
            }
        }
    }

    private func fetchSelectedDays() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        // Fetch selected days from Firestore
        db.collection("weeklyActivity").document(userId).getDocument { document, error in
            if let error = error {
                print("Error fetching training days: \(error.localizedDescription)")
                return
            }

            guard let data = document?.data() else { return }

            if let trainedDays = data["trainedDays"] as? [Bool] {
                let fetchedDays = zip(daysOfWeek, trainedDays).compactMap { $1 ? $0 : nil }
                DispatchQueue.main.async {
                    self.selectedDays = fetchedDays
                }
            }
        }
    }
}
