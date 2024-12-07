//
//  CommunityView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//

//import SwiftUI
//
//struct CommunityView: View {
//    let leaderboardData = [
//        LeaderboardEntry(name: "Asgar Fataymamode", score: 1200, timeSpent: "10h 45m"),
//        LeaderboardEntry(name: "Lionel Messi", score: 1100, timeSpent: "9h 30m"),
//        LeaderboardEntry(name: "Cristiano Ronaldo", score: 1050, timeSpent: "8h 15m"),
//        LeaderboardEntry(name: "Diego Maradona", score: 980, timeSpent: "7h 50m"),
//        LeaderboardEntry(name: "Zinedine Zidane", score: 950, timeSpent: "7h 20m"),
//    ]
//    
//    var body: some View {
//        VStack {
//            Text("Community Leaderboard")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding(.top, 20)
//            
//            Divider()
//            
//            List(leaderboardData) { entry in
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(entry.name)
//                            .font(.headline)
//                        Text("Time Spent: \(entry.timeSpent)")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                    }
//                    Spacer()
//                    Text("\(entry.score) pts")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.blue)
//                }
//                .padding(.vertical, 5)
//            }
//        }
//        .padding(.horizontal)
//    }
//}
//
//struct LeaderboardEntry: Identifiable {
//    let id = UUID()
//    let name: String
//    let score: Int
//    let timeSpent: String
//}
//
//struct CommunityView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityView()
//    }
//}


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CommunityView: View {
    @State private var leaderboardData: [LeaderboardEntry] = []
    private let db = Firestore.firestore()

    var body: some View {
        VStack {
            Text("Community Leaderboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            Divider()

            if leaderboardData.isEmpty {
                Text("Loading...")
                    .font(.headline)
                    .padding()
            } else {
                List(leaderboardData) { entry in
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(entry.name)
                                    .font(.headline)
                                if entry.isTopUser {
                                    Image(systemName: "crown.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                            Text("Time Spent: \(formatTime(entry.totalTime))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("\(entry.score) pts")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .padding(.horizontal)
        .onAppear(perform: fetchLeaderboardData)
    }

    private func fetchLeaderboardData() {
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else { return }

            var entries: [LeaderboardEntry] = []

            for doc in documents {
                let data = doc.data()
                let username = data["username"] as? String ?? "Unknown User"
                let totalTime = data["totalTime"] as? Int ?? 0
                let totalCalories = data["totalCalories"] as? Int ?? 0
                let selectedDays = data["selectedDays"] as? [String] ?? []

                
                let points = calculatePoints(totalTime: totalTime, totalCalories: totalCalories, selectedDaysCount: selectedDays.count)

                let entry = LeaderboardEntry(
                    id: doc.documentID,
                    name: username,
                    score: Int(points),
                    totalTime: totalTime
                )
                entries.append(entry)
            }

            
            entries.sort { $0.score > $1.score }

            
            if !entries.isEmpty {
                entries[0].isTopUser = true
            }

            DispatchQueue.main.async {
                self.leaderboardData = entries
            }
        }
    }

    private func calculatePoints(totalTime: Int, totalCalories: Int, selectedDaysCount: Int) -> Double {
        
        var points = (Double(totalTime) * 0.5) +
                     (Double(totalCalories) / 10.0) +
                     (Double(selectedDaysCount) * 20.0)
        if points > 1000 {
            points = 1000
        }
        return points
    }

    private func formatTime(_ totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m"
    }
}

struct LeaderboardEntry: Identifiable {
    let id: String
    let name: String
    var score: Int
    let totalTime: Int
    var isTopUser: Bool = false
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
