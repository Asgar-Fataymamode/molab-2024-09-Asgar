//
//  UserManager.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 21/11/2024.
//
//import SwiftUI
//
//class UserManager: ObservableObject {
//    @Published var users: [User] = []  // Store all users
//    @Published var isLoggedIn: Bool = false  // Track if a user is logged in
//
//    // Add a new user to the system
//    func addUser(
//        username: String,
//        password: String,
//        age: Int,
//        country: String,
//        skillLevel: String,
//        preferredPosition: String,
//        trainingGoals: String,
//        height: Double,
//        weight: Int,
//        selectedDays: [String],
//        notificationPreference: String
//    ) {
//        let newUser = User(
//            username: username,
//            password: password,
//            age: age,
//            country: country,
//            skillLevel: skillLevel,
//            preferredPosition: preferredPosition,
//            trainingGoals: trainingGoals,
//            height: height,
//            weight: weight,
//            selectedDays: selectedDays,
//            notificationPreference: notificationPreference
//        )
//        users.append(newUser)  // Add the user to the list
//        print("New user added: \(newUser.username)")
//    }
//
//    // Authenticate a user by username and password
//    func authenticate(username: String, password: String) -> Bool {
//        if users.contains(where: { $0.username == username && $0.password == password }) {
//            isLoggedIn = true
//            return true
//        }
//        return false
//    }
//}





import SwiftUI

class UserManager: ObservableObject {
    @Published var users: [User] = []  // Store user data
    @Published var isLoggedIn: Bool = false  // Track login status

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
        // Create a new User object
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
        // Add the user to the list
        users.append(newUser)
        print("New user added: \(newUser.username)")
    }

    func authenticate(username: String, password: String) -> Bool {
        if users.contains(where: { $0.username == username && $0.password == password }) {
            isLoggedIn = true
            return true
        }
        return false
    }
}
