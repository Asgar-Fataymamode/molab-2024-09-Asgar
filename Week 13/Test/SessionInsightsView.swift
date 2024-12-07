//
//  SessionInsightsView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 06/12/2024.

//
//import SwiftUI
//import FirebaseAuth
//import FirebaseFirestore
//
//struct SessionInsightsView: View {
//    @State private var hasTrainedThisWeek: Bool? = nil
//    @State private var daysTrainedThisWeek: Int = 0
//    @State private var trainingDuration: Int = 30 // default if not fetched
//    @State private var totalCalories: Int = 0
//    @State private var totalTime: Int = 0
//    @State private var weeklyCalories: Int = 0
//    @State private var weeklyTime: Int = 0
//    @State private var showResults = false
//    
//    private let db = Firestore.firestore()
//    private let caloriesMap: [Int: Int] = [30:200, 60:400, 90:600, 120:800]
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Session Insights")
//                .font(.headline)
//                .frame(maxWidth: .infinity, alignment: .center)
//            
//            // Ask user if they have trained this week
//            Text("Did you train this week?")
//                .font(.subheadline)
//                .padding(.top, 10)
//            
//            HStack {
//                Button(action: {
//                    hasTrainedThisWeek = true
//                }) {
//                    Text("Yes")
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(hasTrainedThisWeek == true ? Color.blue : Color.gray.opacity(0.3))
//                        .cornerRadius(8)
//                }
//                
//                Button(action: {
//                    hasTrainedThisWeek = false
//                }) {
//                    Text("No")
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(hasTrainedThisWeek == false ? Color.blue : Color.gray.opacity(0.3))
//                        .cornerRadius(8)
//                }
//            }
//            
//            if hasTrainedThisWeek == true {
//                // If user trained this week, ask how many days
//                Text("How many days did you train?")
//                    .font(.subheadline)
//                    .padding(.top, 10)
//                
//                Picker(selection: $daysTrainedThisWeek, label: Text("Days Trained")) {
//                    ForEach(0...7, id: \.self) { num in
//                        Text("\(num)").tag(num)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.vertical, 10)
//            }
//            
//            Button(action: submitData) {
//                Text("Submit")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.green)
//                    .cornerRadius(10)
//            }
//            .padding(.top, 10)
//            
//            if showResults {
//                Divider().padding(.vertical, 10)
//                
//                Text("This Week's Summary")
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("Weekly Time")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                        Text("\(weeklyTime) mins")
//                            .font(.title)
//                            .fontWeight(.bold)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack(alignment: .leading) {
//                        Text("Weekly Calories")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                        Text("\(weeklyCalories) kcal")
//                            .font(.title)
//                            .fontWeight(.bold)
//                    }
//                }
//                .padding(.top, 10)
//                
//                Divider().padding(.vertical, 10)
//                
//                Text("All-Time Summary")
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("Total Time")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                        Text("\(totalTime) mins")
//                            .font(.title)
//                            .fontWeight(.bold)
//                    }
//                    
//                    Spacer()
//                    
//                    VStack(alignment: .leading) {
//                        Text("Total Calories")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                        Text("\(totalCalories) kcal")
//                            .font(.title)
//                            .fontWeight(.bold)
//                    }
//                }
//                .padding(.top, 10)
//            }
//        }
//        .padding()
//        .cornerRadius(10)
//        .padding(.horizontal, 20)
//        .onAppear(perform: fetchUserData)
//    }
//    
//    private func fetchUserData() {
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
//            guard let data = snapshot?.data() else {
//                return
//            }
//            
//            // Fetch training duration, total time, and total calories
//            if let duration = data["trainingDuration"] as? Int {
//                self.trainingDuration = duration
//            }
//            if let tCalories = data["totalCalories"] as? Int {
//                self.totalCalories = tCalories
//            }
//            if let tTime = data["totalTime"] as? Int {
//                self.totalTime = tTime
//            }
//        }
//    }
//    
//    private func submitData() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User not logged in")
//            return
//        }
//
//        // If user didn't train this week, no updates
//        guard hasTrainedThisWeek == true else {
//            showResults = false
//            return
//        }
//        
//        // Calculate weekly time and calories
//        let caloriesPerSession = caloriesMap[trainingDuration] ?? 200
//        weeklyTime = daysTrainedThisWeek * trainingDuration
//        weeklyCalories = daysTrainedThisWeek * caloriesPerSession
//        
//        // Update totals
//        let newTotalTime = totalTime + weeklyTime
//        let newTotalCalories = totalCalories + weeklyCalories
//        
//        // Update Firestore
//        db.collection("users").document(userId).updateData([
//            "totalTime": newTotalTime,
//            "totalCalories": newTotalCalories
//        ]) { error in
//            if let error = error {
//                print("Error updating totals: \(error.localizedDescription)")
//                return
//            }
//            
//            // Update local states
//            self.totalTime = newTotalTime
//            self.totalCalories = newTotalCalories
//            
//            // Show the results
//            self.showResults = true
//        }
//    }
//}


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SessionInsightsView: View {
    @State private var hasTrainedThisWeek: Bool? = nil
    @State private var daysTrainedThisWeek: Int = 0
    @State private var trainingDuration: Int = 30
    @State private var totalCalories: Int = 0
    @State private var totalTime: Int = 0
    @State private var weeklyCalories: Int = 0
    @State private var weeklyTime: Int = 0
    @State private var showResults = false
    @State private var preferredPosition: String = "goalkeeper"
    @State private var skillLevel: String = "beginner"

    @State private var positioningLevel: Int = 20
    @State private var passingLevel: Int = 20
    @State private var attackingLevel: Int = 20
    @State private var defendingLevel: Int = 20
    @State private var tacklingLevel: Int = 20
    @State private var shootingLevel: Int = 20
    @State private var reflexesLevel: Int = 20

    private let db = Firestore.firestore()
    private let caloriesMap: [Int: Int] = [30:200, 60:400, 90:600, 120:800]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Session Insights")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)

            Text("Did you train this week?")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 10)

            HStack {
                Button(action: {
                    hasTrainedThisWeek = true
                }) {
                    Text("Yes")
                        .foregroundColor(.white)
                        .padding()
                        .background(hasTrainedThisWeek == true ? Color.blue : Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }

                Button(action: {
                    hasTrainedThisWeek = false
                }) {
                    Text("No")
                        .foregroundColor(.white)
                        .padding()
                        .background(hasTrainedThisWeek == false ? Color.blue : Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)

            if hasTrainedThisWeek == true {
                Text("How many days did you train?")
                    .font(.subheadline)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .center)

                Picker(selection: $daysTrainedThisWeek, label: Text("Days Trained")) {
                    ForEach(0...7, id: \.self) { num in
                        Text("\(num)").tag(num)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 10)
            }

            Button(action: submitData) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
//                    .frame(maxWidth: .infinity)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.top, 10)

            if showResults {
                Divider().padding(.vertical, 10)

                Text("This Week's Summary")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Weekly Time")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(weeklyTime) mins")
                            .font(.title)
                            .fontWeight(.bold)
                    }

                    Spacer()

                    VStack(alignment: .leading) {
                        Text("Weekly Calories")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(weeklyCalories) kcal")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 10)

                Divider().padding(.vertical, 10)

                Text("All-Time Summary")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Total Time")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(totalTime) mins")
                            .font(.title)
                            .fontWeight(.bold)
                    }

                    Spacer()

                    VStack(alignment: .leading) {
                        Text("Total Calories")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(totalCalories) kcal")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 10)
            }
        }
        .padding()
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .onAppear(perform: fetchUserData)
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

            guard let data = snapshot?.data() else { return }

            if let duration = data["trainingDuration"] as? Int {
                self.trainingDuration = duration
            }
            if let tCalories = data["totalCalories"] as? Int {
                self.totalCalories = tCalories
            }
            if let tTime = data["totalTime"] as? Int {
                self.totalTime = tTime
            }

            self.preferredPosition = data["preferredPosition"] as? String ?? "goalkeeper"
            self.skillLevel = data["skillLevel"] as? String ?? "beginner"

            let initialValue = initialSkillValue(for: skillLevel)
            self.positioningLevel = data["positioningLevel"] as? Int ?? initialValue
            self.passingLevel = data["passingLevel"] as? Int ?? initialValue
            self.attackingLevel = data["attackingLevel"] as? Int ?? initialValue
            self.defendingLevel = data["defendingLevel"] as? Int ?? initialValue
            self.tacklingLevel = data["tacklingLevel"] as? Int ?? initialValue
            self.shootingLevel = data["shootingLevel"] as? Int ?? initialValue
            self.reflexesLevel = data["reflexesLevel"] as? Int ?? initialValue

            self.initializeSkillsIfNeeded(data: data, userId: userId, initialValue: initialValue)
        }
    }

    private func submitData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        guard hasTrainedThisWeek == true else {
            showResults = false
            return
        }


        let caloriesPerSession = caloriesMap[trainingDuration] ?? 200
        weeklyTime = daysTrainedThisWeek * trainingDuration
        weeklyCalories = daysTrainedThisWeek * caloriesPerSession


        let newTotalTime = totalTime + weeklyTime
        let newTotalCalories = totalCalories + weeklyCalories

        let incrementPerSession: Int
        if trainingDuration == 30 || trainingDuration == 60 {
            incrementPerSession = 1
        } else {
            incrementPerSession = 2
        }
        let totalIncrements = incrementPerSession * daysTrainedThisWeek

        var skillUpdates = skillIncrements(for: preferredPosition, increment: totalIncrements)

        skillUpdates["totalTime"] = newTotalTime
        skillUpdates["totalCalories"] = newTotalCalories


        db.collection("users").document(userId).updateData(skillUpdates) { error in
            if let error = error {
                print("Error updating totals: \(error.localizedDescription)")
                return
            }


            self.totalTime = newTotalTime
            self.totalCalories = newTotalCalories

            self.applySkillUpdates(skillUpdates)

            self.showResults = true
        }
    }

    private func skillIncrements(for position: String, increment: Int) -> [String: Any] {
        var updates = [String: Any]()

        switch position.lowercased() {
        case "goalkeeper":
            updates["positioningLevel"] = positioningLevel + 3*increment
            updates["reflexesLevel"] = reflexesLevel + 2*increment
            updates["passingLevel"] = passingLevel + increment
        case "defender":
            updates["positioningLevel"] = positioningLevel + 2*increment
            updates["tacklingLevel"] = tacklingLevel + 3*increment
            updates["passingLevel"] = passingLevel + increment
        case "midfielder":
            updates["passingLevel"] = passingLevel + 3*increment
            updates["defendingLevel"] = defendingLevel + increment
            updates["attackingLevel"] = attackingLevel + 2*increment
        case "striker":
            updates["positioningLevel"] = positioningLevel + 2*increment
            updates["shootingLevel"] = shootingLevel + 3*increment
            updates["passingLevel"] = passingLevel + increment
        default:
            updates["passingLevel"] = passingLevel + 3*increment
            updates["defendingLevel"] = defendingLevel + 2*increment
            updates["attackingLevel"] = attackingLevel + increment
        }

        return updates
    }

    private func applySkillUpdates(_ updates: [String: Any]) {
        if let newPos = updates["positioningLevel"] as? Int {
            positioningLevel = newPos
        }
        if let newRef = updates["reflexesLevel"] as? Int {
            reflexesLevel = newRef
        }
        if let newPass = updates["passingLevel"] as? Int {
            passingLevel = newPass
        }
        if let newAtt = updates["attackingLevel"] as? Int {
            attackingLevel = newAtt
        }
        if let newDef = updates["defendingLevel"] as? Int {
            defendingLevel = newDef
        }
        if let newTack = updates["tacklingLevel"] as? Int {
            tacklingLevel = newTack
        }
        if let newShoot = updates["shootingLevel"] as? Int {
            shootingLevel = newShoot
        }
    }

    private func initializeSkillsIfNeeded(data: [String: Any], userId: String, initialValue: Int) {
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
        default: return 0
        }
    }
}
