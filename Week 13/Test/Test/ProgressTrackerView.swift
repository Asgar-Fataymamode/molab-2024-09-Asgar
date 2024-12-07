////
////  ProgressTrackerView.swift
////  Test
////
////  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
////
////
//import SwiftUI
//
//struct ProgressTrackerView: View {
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 30) {
//                    VStack {
//                        CircularProgressView(progress: 0.75, label: "75% Complete")
//                            .frame(width: 150, height: 150)
//                            .padding()
//                    }
//                    
//                    Divider()
//                    
//                    VStack(alignment: .leading) {
//                        Text("Activity Breakdown")
//                            .font(.headline)
//                            .frame(maxWidth: .infinity, alignment: .center)
//                        
//                        HStack(spacing: 20) {
//                            CircularProgressView(progress: 0.8, label: "Shooting")
//                                .frame(width: 100, height: 100)
//                                .padding(.leading, 55)
//                            
//                            CircularProgressView(progress: 0.65, label: "Passing")
//                                .frame(width: 100, height: 100)
//                            
//                            CircularProgressView(progress: 0.6, label: "Dribbling")
//                                .frame(width: 100, height: 100)
//                        }
//                        .padding(.horizontal, 10)
//                    }
//                    
//                    Divider()
//                    
//                    WeeklyActivitySummaryView()
//                    
//                    Divider()
//                    
//                    SessionInsightsView()
//                    
//                    Spacer()
//                }
//                .padding()
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("Overall Training Progress")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                }
//            }
//        }
//    }
//}
//
//
//struct CircularProgressView: View {
//    var progress: CGFloat
//    var label: String
//    
//    var body: some View {
//        ZStack {
//            Circle()
//                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
//            Circle()
//                .trim(from: 0, to: progress)
//                .stroke(Color.blue, lineWidth: 10)
//                .rotationEffect(.degrees(-90))
//                .animation(.easeOut, value: progress)
//            
//            VStack {
//                Text(String(format: "%.0f%%", progress * 100))
//                    .font(.title2)
//                    .fontWeight(.bold)
//                Text(label)
//                    .font(.footnote)
//                    .foregroundColor(.gray)
//            }
//        }
//    }
//}
//
//struct WeeklyActivitySummaryView: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            Text("Weekly Activity Summary")
//                .font(.headline)
//                .frame(maxWidth: .infinity, alignment: .center)
//            
//            HStack(spacing: 15) {
//                ForEach(0..<7) { day in
//                    WeeklyDayView(day: ["M", "T", "W", "T", "F", "S", "S"][day], trained: day % 2 == 0)
//                }
//            }
//            .padding()
//            
//            Text("5 out of 7 days trained this week")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//                .frame(maxWidth: .infinity, alignment: .center)
//        }
//        .padding()
//        .cornerRadius(10)
//        .padding(.horizontal, 20)
//    }
//}
//
//
//struct WeeklyDayView: View {
//    let day: String
//    let trained: Bool
//    
//    var body: some View {
//        VStack {
//            Circle()
//                .fill(trained ? Color.green : Color.gray.opacity(0.3))
//                .frame(width: 40, height: 40)
//                .overlay(Text(day)
//                            .font(.caption)
//                            .foregroundColor(.white))
//            
//            Text(trained ? "✔︎" : "✘")
//                .font(.footnote)
//                .foregroundColor(trained ? .green : .gray)
//        }
//    }
//}
//
//struct SessionInsightsView: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Session Insights")
//                .font(.headline)
//                .frame(maxWidth: .infinity, alignment: .center)
//            
//            HStack {
//                VStack {
//                    Text("Avg Session")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                    Text("45 mins")
//                        .font(.title)
//                        .fontWeight(.bold)
//                }
//                
//                Spacer()
//                
//                VStack {
//                    Text("Calories Burned")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                    Text("350 kcal")
//                        .font(.title)
//                        .fontWeight(.bold)
//                }
//            }
//            .padding(.horizontal, 20)
//        }
//        .padding()
//        .cornerRadius(10)
//        .padding(.horizontal, 20)
//    }
//}
//
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProgressTrackerView: View {
    @State private var trainedDays: [String] = []
    @State private var skillLevel: String = "Beginner"
    @State private var preferredPosition: String = "Goalkeeper"

    // Skill values as percentages (0.0 to 1.0)
    @State private var positioning: CGFloat = 0.2
    @State private var passing: CGFloat = 0.2
    @State private var attacking: CGFloat = 0.2
    @State private var defending: CGFloat = 0.2
    @State private var tackling: CGFloat = 0.2
    @State private var shooting: CGFloat = 0.2
    @State private var reflexes: CGFloat = 0.2

    // Derived skills to show based on position
    @State private var skillLabels: [String] = []
    @State private var skillValues: [CGFloat] = []

    private let db = Firestore.firestore()
    private let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Overall average progress
                    let avgProgress = skillValues.isEmpty ? 0.0 : skillValues.reduce(0, +) / CGFloat(skillValues.count)
                    VStack {
                        CircularProgressView(progress: avgProgress, label: String(format: "%.0f%% Complete", avgProgress * 100))
                            .frame(width: 150, height: 150)
                            .padding()
                    }

                    Divider()

                    VStack(alignment: .leading) {
                        Text("Activity Breakdown")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .center)

                        HStack(spacing: 20) {
                            if skillLabels.count == 3 {
                                CircularProgressView(progress: skillValues[0], label: skillLabels[0].capitalized)
                                    .frame(width: 100, height: 100)
                                    .padding(.leading, 55)

                                CircularProgressView(progress: skillValues[1], label: skillLabels[1].capitalized)
                                    .frame(width: 100, height: 100)

                                CircularProgressView(progress: skillValues[2], label: skillLabels[2].capitalized)
                                    .frame(width: 100, height: 100)
                            }
                        }
                        .padding(.horizontal, 10)
                    }

                    Divider()

                    WeeklyActivitySummaryView(trainedDays: trainedDays)

                    Divider()

                    SessionInsightsView()

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Overall Training")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
        }
        .onAppear {
            fetchUserData()
        }
    }

    private func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        db.collection("users").document(userId).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }

            guard let data = snapshot?.data() else {
                print("No user data found")
                return
            }

            let selectedDays = data["selectedDays"] as? [String] ?? []
            let userSkillLevel = data["skillLevel"] as? String ?? "Beginner"
            let userPosition = data["preferredPosition"] as? String ?? "Goalkeeper"

            DispatchQueue.main.async {
                self.trainedDays = selectedDays
                self.skillLevel = userSkillLevel
                self.preferredPosition = userPosition

                
                let initialValue = initialSkillValue(for: userSkillLevel)

                let positioningVal = data["positioningLevel"] as? Int ?? initialValue
                let passingVal = data["passingLevel"] as? Int ?? initialValue
                let attackingVal = data["attackingLevel"] as? Int ?? initialValue
                let defendingVal = data["defendingLevel"] as? Int ?? initialValue
                let tacklingVal = data["tacklingLevel"] as? Int ?? initialValue
                let shootingVal = data["shootingLevel"] as? Int ?? initialValue
                let reflexesVal = data["reflexesLevel"] as? Int ?? initialValue

                self.positioning = CGFloat(positioningVal) / 100.0
                self.passing = CGFloat(passingVal) / 100.0
                self.attacking = CGFloat(attackingVal) / 100.0
                self.defending = CGFloat(defendingVal) / 100.0
                self.tackling = CGFloat(tacklingVal) / 100.0
                self.shooting = CGFloat(shootingVal) / 100.0
                self.reflexes = CGFloat(reflexesVal) / 100.0

                
                let (labels, values) = skillsForPosition(userPosition: userPosition)
                self.skillLabels = labels
                self.skillValues = values

                
                self.initializeSkillsIfNeeded(data: data, userId: userId, initialValue: initialValue, currentValues: [
                    "positioningLevel": positioningVal,
                    "passingLevel": passingVal,
                    "attackingLevel": attackingVal,
                    "defendingLevel": defendingVal,
                    "tacklingLevel": tacklingVal,
                    "shootingLevel": shootingVal,
                    "reflexesLevel": reflexesVal
                ])
            }
        }
    }

    private func initializeSkillsIfNeeded(data: [String: Any], userId: String, initialValue: Int, currentValues: [String: Int]) {
        var updates = [String: Any]()
        let skillKeys = ["positioningLevel", "passingLevel", "attackingLevel", "defendingLevel", "tacklingLevel", "shootingLevel", "reflexesLevel"]

        for key in skillKeys {
            if data[key] == nil {
                updates[key] = initialValue
            }
        }

        if !updates.isEmpty {
            db.collection("users").document(userId).updateData(updates) { error in
                if let error = error {
                    print("Error initializing skill fields: \(error.localizedDescription)")
                }
            }
        }
    }

    private func initialSkillValue(for skillLevel: String) -> Int {
        switch skillLevel.lowercased() {
        case "beginner": return 0
        case "intermediate": return 20
        case "advanced": return 40
        default: return 20
        }
    }

    private func skillsForPosition(userPosition: String) -> ([String], [CGFloat]) {
        switch userPosition.lowercased() {
        case "goalkeeper":
            return (["positioning", "reflexes", "passing"], [positioning, reflexes, passing])
        case "defender":
            return (["positioning", "tackling", "passing"], [positioning, tackling, passing])
        case "midfielder":
            return (["passing", "defending", "attacking"], [passing, defending, attacking])
        case "striker":
            return (["positioning", "shooting", "passing"], [positioning, shooting, passing])
        default:
            // default to midfielder if something unexpected
            return (["passing", "defending", "attacking"], [passing, defending, attacking])
        }
    }
}


struct CircularProgressView: View {
    var progress: CGFloat
    var label: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, lineWidth: 10)
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)

            VStack {
                Text(String(format: "%.0f%%", progress * 100))
                    .font(.title2)
                    .fontWeight(.bold)
                Text(label)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}


//
//import SwiftUI
//import FirebaseAuth
//import FirebaseFirestore
//
//struct ProgressTrackerView: View {
//    @State private var trainedDays: [String] = []
//    private let db = Firestore.firestore()
//    private let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 30) {
//                    VStack {
//                        CircularProgressView(progress: 0.75, label: "75% Complete")
//                            .frame(width: 150, height: 150)
//                            .padding()
//                    }
//
//                    Divider()
//
//                    VStack(alignment: .leading) {
//                        Text("Activity Breakdown")
//                            .font(.headline)
//                            .frame(maxWidth: .infinity, alignment: .center)
//
//                        HStack(spacing: 20) {
//                            CircularProgressView(progress: 0.8, label: "Attacking")
//                                .frame(width: 100, height: 100)
//                                .padding(.leading, 55)
//
//                            CircularProgressView(progress: 0.65, label: "Passing")
//                                .frame(width: 100, height: 100)
//
//                            CircularProgressView(progress: 0.6, label: "Defending")
//                                .frame(width: 100, height: 100)
//                        }
//                        .padding(.horizontal, 10)
//                    }
//
//                    Divider()
//
//                    WeeklyActivitySummaryView(trainedDays: trainedDays)
//
//                    Divider()
//
//                    SessionInsightsView()
//
//                    Spacer()
//                }
//                .padding()
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("Overall Training")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                }
//            }
//        }
//        .onAppear(perform: fetchUserTrainingDays)
//    }
//
//    private func fetchUserTrainingDays() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User not logged in")
//            return
//        }
//
//        db.collection("users").document(userId).getDocument { snapshot, error in
//            if let error = error {
//                print("Error fetching user data: \(error.localizedDescription)")
//                return
//            }
//
//            guard let data = snapshot?.data(), let selectedDays = data["selectedDays"] as? [String] else {
//                print("No selectedDays found for the user")
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.trainedDays = selectedDays
//            }
//        }
//    }
//}
//
//struct CircularProgressView: View {
//    var progress: CGFloat
//    var label: String
//
//    var body: some View {
//        ZStack {
//            Circle()
//                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
//            Circle()
//                .trim(from: 0, to: progress)
//                .stroke(Color.blue, lineWidth: 10)
//                .rotationEffect(.degrees(-90))
//                .animation(.easeOut, value: progress)
//
//            VStack {
//                Text(String(format: "%.0f%%", progress * 100))
//                    .font(.title2)
//                    .fontWeight(.bold)
//                Text(label)
//                    .font(.footnote)
//                    .foregroundColor(.gray)
//            }
//        }
//    }
//}
