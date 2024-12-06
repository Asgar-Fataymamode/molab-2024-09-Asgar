//
//
//
//
//import SwiftUI
//import FirebaseFirestore
//import FirebaseAuth
//
//struct GoalsChallengesView: View {
//    @State private var ongoingGoals: [Goal] = []
//    @State private var completedGoals: [Goal] = []
//    @State private var selectedGoal: Goal?
//    @State private var showGoalDetails = false
//    @State private var showAddGoalForm = false
//    @State private var navigateToSkills = false
//
//    private let db = Firestore.firestore()
//
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: .top) {
//                ScrollViewReader { proxy in
//                    ScrollView {
//                        VStack(spacing: 20) {
//                            Text("Goals & Challenges")
//                                .font(.largeTitle)
//                                .fontWeight(.bold)
//                                .padding(.top, 20)
//                            
//                            Divider()
//                            
//                            VStack(alignment: .leading, spacing: 10) {
//                                Text("Ongoing Goals")
//                                    .font(.headline)
//                                
//                                ForEach(ongoingGoals) { goal in
//                                    GoalRowView(goal: goal, onComplete: {
//                                        completeGoal(goal)
//                                    })
//                                    .onTapGesture {
//                                        selectedGoal = goal
//                                        showGoalDetails = true
//                                    }
//                                }
//                            }
//                            .padding(.horizontal)
//                            
//                            Divider()
//                            
//                            VStack(alignment: .leading, spacing: 10) {
//                                Text("Completed Goals")
//                                    .font(.headline)
//                                
//                                ForEach(completedGoals) { goal in
//                                    CompletedGoalRowView(goal: goal)
//                                }
//                            }
//                            .padding(.horizontal)
//                            
//                            Divider()
//                            
//                            Button(action: {
//                                showAddGoalForm = true
//                            }) {
//                                Text("Add New Goal")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .frame(maxWidth: .infinity)
//                                    .background(Color.green)
//                                    .cornerRadius(10)
//                            }
//                            .padding(.horizontal)
//                            
//                            Button(action: {
//                                withAnimation {
//                                    navigateToSkills = true
//                                    proxy.scrollTo("skillsSection", anchor: .bottom)
//                                }
//                            }) {
//                                Text("Explore Skills")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .frame(maxWidth: .infinity)
//                                    .background(Color.blue)
//                                    .cornerRadius(10)
//                            }
//                            .padding(.horizontal)
//                            .id("skillsSection")
//                        }
//                    }
//                    .sheet(isPresented: $showGoalDetails) {
//                        if let goal = selectedGoal {
//                            GoalDetailView(goal: goal) { updatedGoal in
//                                updateGoal(updatedGoal)
//                            }
//                        }
//                    }
//                    .sheet(isPresented: $showAddGoalForm) {
//                        AddGoalView { newGoal in
//                            addGoalToDatabase(newGoal)
//                        }
//                    }
//                    .navigationDestination(isPresented: $navigateToSkills) {
//                        SkillListView()
//                    }
//                }
//            }
//        }
//        .onAppear(perform: fetchGoals)
//    }
//    
//    private func completeGoal(_ goal: Goal) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//
//        if let index = ongoingGoals.firstIndex(where: { $0.id == goal.id }) {
//            var completedGoal = ongoingGoals.remove(at: index)
//            completedGoal.isCompleted = true
//            completedGoal.completionDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
//            completedGoals.insert(completedGoal, at: 0)
//
//            db.collection("goals")
//                .document(completedGoal.id.uuidString)
//                .updateData([
//                    "isCompleted": true,
//                    "completionDate": completedGoal.completionDate ?? ""
//                ]) { error in
//                    if let error = error {
//                        print("Error updating goal: \(error.localizedDescription)")
//                    } else {
//                        print("Goal marked as completed in Firestore.")
//                    }
//                }
//        }
//    }
//
//    private func updateGoal(_ updatedGoal: Goal) {
//        if let index = ongoingGoals.firstIndex(where: { $0.id == updatedGoal.id }) {
//            ongoingGoals[index] = updatedGoal
//        } else if let index = completedGoals.firstIndex(where: { $0.id == updatedGoal.id }) {
//            completedGoals[index] = updatedGoal
//        }
//        
//        updateGoalInDatabase(updatedGoal)
//    }
//
//    private func addGoalToDatabase(_ goal: Goal) {
//        let goalID = goal.id.uuidString
//        let goalData: [String: Any] = [
//            "name": goal.name,
//            "progress": goal.progress,
//            "isCompleted": goal.isCompleted,
//            "completionDate": goal.completionDate ?? "",
//            "userId": goal.userId
//        ]
//        
//        db.collection("goals").document(goalID).setData(goalData) { error in
//            if let error = error {
//                print("Error adding goal: \(error.localizedDescription)")
//            } else {
//                fetchGoals() 
//            }
//        }
//    }
//
//    private func updateGoalInDatabase(_ goal: Goal) {
//        let goalID = goal.id.uuidString
//        db.collection("goals").document(goalID).setData([
//            "name": goal.name,
//            "progress": goal.progress,
//            "isCompleted": goal.isCompleted,
//            "completionDate": goal.completionDate ?? "",
//            "userId": goal.userId
//        ], merge: true) { error in
//            if let error = error {
//                print("Error updating goal: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    private func fetchGoals() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("User not logged in")
//            return
//        }
//
//        db.collection("goals")
//            .whereField("userId", isEqualTo: userId)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error fetching goals: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let documents = snapshot?.documents else { return }
//
//                var fetchedOngoingGoals: [Goal] = []
//                var fetchedCompletedGoals: [Goal] = []
//
//                for document in documents {
//                    let data = document.data()
//                    let goal = Goal(
//                        id: UUID(uuidString: document.documentID) ?? UUID(),
//                        name: data["name"] as? String ?? "",
//                        progress: data["progress"] as? Double ?? 0.0,
//                        isCompleted: data["isCompleted"] as? Bool ?? false,
//                        completionDate: data["completionDate"] as? String,
//                        userId: data["userId"] as? String ?? userId
//                    )
//
//                    if goal.isCompleted {
//                        fetchedCompletedGoals.append(goal)
//                    } else {
//                        fetchedOngoingGoals.append(goal)
//                    }
//                }
//
//                DispatchQueue.main.async {
//                    self.ongoingGoals = fetchedOngoingGoals
//                    self.completedGoals = fetchedCompletedGoals
//                }
//            }
//    }
//}


import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct GoalsChallengesView: View {
    @State private var ongoingGoals: [Goal] = []
    @State private var completedGoals: [Goal] = []
    @State private var selectedGoal: Goal?
    @State private var showGoalDetails = false
    @State private var showAddGoalForm = false
    @State private var navigateToSkills = false

    private let db = Firestore.firestore()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 20) {
                            Text("Goals & Challenges")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                            
                            Divider()
                            
                            // Ongoing Goals Section
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Ongoing Goals")
                                    .font(.headline)
                                
                                ForEach(ongoingGoals) { goal in
                                    GoalRowView(goal: goal, onComplete: {
                                        completeGoal(goal)
                                    })
                                    .onTapGesture {
                                        selectedGoal = goal
                                        showGoalDetails = true
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                            // Completed Goals Section
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Completed Goals")
                                    .font(.headline)
                                
                                ForEach(completedGoals) { goal in
                                    CompletedGoalRowView(goal: goal)
                                }
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                            // Add New Goal Button
                            Button(action: {
                                showAddGoalForm = true
                            }) {
                                Text("Add New Goal")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                            
                            // Explore Skills Button
                            Button(action: {
                                withAnimation {
                                    navigateToSkills = true
                                    proxy.scrollTo("skillsSection", anchor: .bottom)
                                }
                            }) {
                                Text("Explore Skills")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                            .id("skillsSection")
                        }
                    }
                    .sheet(isPresented: $showGoalDetails) {
                        if let goal = selectedGoal {
                            GoalDetailView(goal: goal) { updatedGoal in
                                updateGoal(updatedGoal)
                            }
                        }
                    }
                    .sheet(isPresented: $showAddGoalForm) {
                        AddGoalView { newGoal in
                            addGoalToDatabase(newGoal)
                        }
                    }
                    .navigationDestination(isPresented: $navigateToSkills) {
                        SkillListView()
                    }
                }
            }
        }
        .onAppear(perform: fetchGoals)
    }
    
    private func completeGoal(_ goal: Goal) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        if let index = ongoingGoals.firstIndex(where: { $0.id == goal.id }) {
            var completedGoal = ongoingGoals.remove(at: index)
            completedGoal.isCompleted = true
            completedGoal.completionDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
            completedGoals.insert(completedGoal, at: 0)

            // Update the goal's status in Firestore
            db.collection("goals")
                .document(completedGoal.id.uuidString)
                .updateData([
                    "isCompleted": true,
                    "completionDate": completedGoal.completionDate ?? ""
                ]) { error in
                    if let error = error {
                        print("Error updating goal: \(error.localizedDescription)")
                    } else {
                        print("Goal marked as completed in Firestore.")
                        // Fetch again to ensure UI sync
                        fetchGoals()
                    }
                }
        }
    }

    private func updateGoal(_ updatedGoal: Goal) {
        // Update local arrays
        if let index = ongoingGoals.firstIndex(where: { $0.id == updatedGoal.id }) {
            ongoingGoals[index] = updatedGoal
        } else if let index = completedGoals.firstIndex(where: { $0.id == updatedGoal.id }) {
            completedGoals[index] = updatedGoal
        } else {
            // If the goal isn't found, insert accordingly
            if updatedGoal.isCompleted {
                completedGoals.insert(updatedGoal, at: 0)
            } else {
                ongoingGoals.insert(updatedGoal, at: 0)
            }
        }

        // Now update the database
        updateGoalInDatabase(updatedGoal) { success in
            if success {
                // Refresh goals after successful database update to ensure consistency
                fetchGoals()
            }
        }
    }

    private func addGoalToDatabase(_ goal: Goal) {
        let goalID = goal.id.uuidString
        let goalData: [String: Any] = [
            "name": goal.name,
            "progress": goal.progress,
            "isCompleted": goal.isCompleted,
            "completionDate": goal.completionDate ?? "",
            "userId": goal.userId
        ]
        
        db.collection("goals").document(goalID).setData(goalData) { error in
            if let error = error {
                print("Error adding goal: \(error.localizedDescription)")
            } else {
                fetchGoals() // Refresh goals after adding
            }
        }
    }

    private func updateGoalInDatabase(_ goal: Goal, completion: @escaping (Bool) -> Void) {
        let goalID = goal.id.uuidString
        db.collection("goals").document(goalID).setData([
            "name": goal.name,
            "progress": goal.progress,
            "isCompleted": goal.isCompleted,
            "completionDate": goal.completionDate ?? "",
            "userId": goal.userId
        ], merge: true) { error in
            if let error = error {
                print("Error updating goal: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    private func fetchGoals() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        db.collection("goals")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching goals: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else { return }

                var fetchedOngoingGoals: [Goal] = []
                var fetchedCompletedGoals: [Goal] = []

                for document in documents {
                    let data = document.data()
                    let goal = Goal(
                        id: UUID(uuidString: document.documentID) ?? UUID(),
                        name: data["name"] as? String ?? "",
                        progress: data["progress"] as? Double ?? 0.0,
                        isCompleted: data["isCompleted"] as? Bool ?? false,
                        completionDate: data["completionDate"] as? String,
                        userId: data["userId"] as? String ?? userId
                    )

                    if goal.isCompleted {
                        fetchedCompletedGoals.append(goal)
                    } else {
                        fetchedOngoingGoals.append(goal)
                    }
                }

                DispatchQueue.main.async {
                    self.ongoingGoals = fetchedOngoingGoals
                    self.completedGoals = fetchedCompletedGoals
                }
            }
    }
}
