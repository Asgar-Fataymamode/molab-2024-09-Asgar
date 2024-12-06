//
//  SignInView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignInView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var email = ""
    @State private var password = ""
    @State private var message = ""
    @State private var navigateToDashboard = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Sign In")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: signIn) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Text(message)
                    .foregroundColor(.red)

                
                NavigationLink(
                    destination: DashboardView(),
                    isActive: $navigateToDashboard
                ) {
                    EmptyView()
                }
            }
            .padding()
        }
    }

    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                message = "Error: \(error.localizedDescription)"
            } else if let user = authResult?.user {
                fetchUserData(uid: user.uid)
            }
        }
    }

    func fetchUserData(uid: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let userData = document.data()
                userManager.currentUser = UserModel(
                    uid: uid,
                    username: userData?["username"] as? String ?? "",
                    email: userData?["email"] as? String ?? "",
                    age: userData?["age"] as? Int ?? 0,
                    country: userData?["country"] as? String ?? "",
                    skillLevel: userData?["skillLevel"] as? String ?? "",
                    preferredPosition: userData?["preferredPosition"] as? String ?? "",
                    trainingGoals: userData?["trainingGoals"] as? String ?? "",
                    experience: userData?["experience"] as? String ?? "",
                    height: userData?["height"] as? Double ?? 0.0,
                    weight: userData?["weight"] as? Int ?? 0,
                    selectedDays: userData?["selectedDays"] as? [String] ?? [],
                    trainingDuration: userData?["trainingDuration"] as? Int ?? 0,
                    notificationPreference: userData?["notificationPreference"] as? String ?? "",
                    profileImagePath: userData?["profileImagePath"] as? String ?? ""
                )
                userManager.isLoggedIn = true
                navigateToDashboard = true 
//                message = "User signed in successfully!"
            } else {
                message = "Error fetching user data: \(error?.localizedDescription ?? "Unknown error")"
            }
        }
    }
}
