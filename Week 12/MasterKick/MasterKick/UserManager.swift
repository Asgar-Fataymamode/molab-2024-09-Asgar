


import SwiftUI

class UserManager: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?  

    func addUser(
        username: String,
        password: String,
        age: Int,
        country: String,
        skillLevel: String,
        preferredPosition: String,
        trainingGoals: String,
        experience: String,
        height: Double,
        weight: Int,
        selectedDays: [String],
        trainingDuration: Int,
        notificationPreference: String
    ) {
        let newUser = User(
            username: username,
            password: password,
            age: age,
            country: country,
            skillLevel: skillLevel,
            preferredPosition: preferredPosition,
            trainingGoals: trainingGoals,
            experience: experience,
            height: height,
            weight: weight,
            selectedDays: selectedDays,
            trainingDuration: trainingDuration,
            notificationPreference: notificationPreference
        )

        users.append(newUser)
        print("New user added: \(newUser.username)")
    }

    func authenticate(username: String, password: String) -> Bool {
        if let user = users.first(where: { $0.username == username && $0.password == password }) {
            isLoggedIn = true
            currentUser = user
            print("User logged in: \(user.username)")
            return true
        }
        return false
    }

    func logout() {
        isLoggedIn = false
        currentUser = nil
        print("User logged out")
    }
}


