//
//  SignUpView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//

import SwiftUI
import FirebaseFirestore

struct SignUpView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var age: String = ""
    @State private var country: String = ""
    @State private var skillLevel: String = "Beginner"
    @State private var preferredPosition: String = "Goalkeeper"
    @State private var trainingGoals: String = ""
    @State private var experience: String = ""
    @State private var height: Double = 1.70
    @State private var weight: Int = 70
    @State private var selectedDays: [String] = []
    @State private var trainingDuration: Int = 30
    @State private var notificationPreference: String = "Daily"
    @State private var profileImage: Image? = nil
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""

    let skillLevels = ["Beginner", "Intermediate", "Advanced"]
    let preferredPositions = ["Goalkeeper", "Defender", "Midfielder", "Striker"]
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let trainingDurations = [30, 60, 90, 120]
    let notificationOptions = ["Daily", "Weekly", "Monthly", "None"]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                VStack {
                    if profileImage != nil {
                        profileImage?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            .shadow(radius: 5)
                    } else {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                    }
                    Button(action: {
                        self.showImagePicker = true
                    }) {
                        Text("Upload Profile Picture")
                    }
                }
                .padding()

                Group {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)

                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)

                    TextField("Country", text: $country)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

                HeightPicker(height: $height)
                WeightPicker(weight: $weight)

                Group {
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
                }

                DaySelectionView(selectedDays: $selectedDays, daysOfWeek: daysOfWeek)

                PickerView(title: "Skill Level", options: skillLevels, selection: $skillLevel)
                PickerView(title: "Preferred Position", options: preferredPositions, selection: $preferredPosition)
                PickerView(title: "Training Duration", options: trainingDurations.map { "\($0) mins" }, selection: Binding(
                    get: { "\(trainingDuration) mins" },
                    set: { trainingDuration = Int($0.split(separator: " ")[0]) ?? 30 }
                ))
                PickerView(title: "Notification Preference", options: notificationOptions, selection: $notificationPreference)

                Button(action: {
                    handleSignUp()
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .alert(isPresented: $showErrorAlert) {
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }

    private func handleSignUp() {
        guard let ageInt = Int(age), !email.isEmpty, !username.isEmpty, !password.isEmpty else {
            showError(message: "Please fill all the required fields.")
            return
        }

        userManager.addUserWithDetails(
            email: email, 
            username: username,
            password: password,
            age: ageInt,
            country: country,
            skillLevel: skillLevel,
            preferredPosition: preferredPosition,
            trainingGoals: trainingGoals,
            experience: experience,
            height: height,
            weight: weight,
            selectedDays: selectedDays,
            trainingDuration: trainingDuration,
            notificationPreference: notificationPreference,
            profileImage: inputImage
        ) { success, error in
            if let error = error {
                showError(message: error.localizedDescription)
            } else {
                print("User successfully signed up!")
            }
        }
    }

    private func showError(message: String) {
        self.errorMessage = message
        self.showErrorAlert = true
    }

    private func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}


