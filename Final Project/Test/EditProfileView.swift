//
//  EditProfileView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//

import SwiftUI

import FirebaseFirestore

struct EditProfileView: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) var dismiss

    @State private var username: String = ""
    @State private var email: String = ""
    @State private var country: String = ""
    @State private var skillLevel: String = "Beginner"
    @State private var preferredPosition: String = "Goalkeeper"
    @State private var trainingGoals: String = ""
    @State private var experience: String = ""

    let skillLevels = ["Beginner", "Intermediate", "Advanced"]
    let positions = ["Goalkeeper", "Defender", "Midfielder", "Striker"]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Edit Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                TextField("Country", text: $country)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                
                Picker("Skill Level", selection: $skillLevel) {
                    ForEach(skillLevels, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)

                
                Picker("Preferred Position", selection: $preferredPosition) {
                    ForEach(positions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)

                TextField("Training Goals", text: $trainingGoals)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                TextField("Experience", text: $experience)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                
                Button(action: saveChanges) {
                    Text("Save Changes")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
            }
        }
        .onAppear {
            loadUserData()
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func loadUserData() {
        
        if let user = userManager.currentUser {
            username = user.username
            email = user.email
            country = user.country
            skillLevel = user.skillLevel
            preferredPosition = user.preferredPosition
            trainingGoals = user.trainingGoals
            experience = user.experience
        }
    }

    private func saveChanges() {
        
        guard let userId = userManager.currentUser?.uid else { return }

        let updatedData: [String: Any] = [
            "username": username,
            "email": email,
            "country": country,
            "skillLevel": skillLevel,
            "preferredPosition": preferredPosition,
            "trainingGoals": trainingGoals,
            "experience": experience
        ]

        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData(updatedData) { error in
            if let error = error {
                print("Error updating user data: \(error.localizedDescription)")
            } else {
                print("User data updated successfully!")
                userManager.fetchCurrentUser()
                dismiss()
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(UserManager())
    }
}
