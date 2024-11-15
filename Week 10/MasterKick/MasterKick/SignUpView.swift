//
//  SignUpView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.
//
//




import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
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
    @State private var selectedCountry: String = "United States"
    @State private var notificationPreference: String = "Daily"
    @State private var profileImage: Image? = nil
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    
    @State private var showHeightPicker: Bool = false
    @State private var showWeightPicker: Bool = false

    let skillLevels = ["Beginner", "Intermediate", "Advanced"]
    let preferredPositions = ["Goalkeeper", "Defender", "Midfielder", "Striker"]
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let trainingDurations = [30, 60, 90, 120]
    let countries = ["United States", "Canada", "United Kingdom", "Australia", "India", "France"]
    let notificationOptions = ["Daily", "Weekly", "Monthly", "None"]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                //Profile Picture Upload
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

                //Username and Password Fields
                Group {
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
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

//                // Height Picker (Show Only on Tap)
//                VStack {
//                    Text("Height (m)")
//                        .font(.headline)
//                    Text(String(format: "%.2f m", height))
//                        .padding()
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                        .padding(.horizontal, 20)
//                        .onTapGesture {
//                            showHeightPicker.toggle()
//                        }
//
//                    if showHeightPicker {
//                        Picker("Height", selection: $height) {
//                            ForEach(Array(stride(from: 1.20, through: 2.50, by: 0.01)), id: \.self) { value in
//                                Text(String(format: "%.2f", value))
//                            }
//                        }
//                        .pickerStyle(.wheel)
//                        .frame(height: 100)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                        .padding(.horizontal, 20)
//                    }
//                }
//
//                // Weight Picker (Show Only on Tap)
//                VStack {
//                    Text("Weight (kg)")
//                        .font(.headline)
//                    Text("\(weight) kg")
//                        .padding()
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                        .padding(.horizontal, 20)
//                        .onTapGesture {
//                            showWeightPicker.toggle()
//                        }
//
//                    if showWeightPicker {
//                        Picker("Weight", selection: $weight) {
//                            ForEach(40...150, id: \.self) { value in
//                                Text("\(value)")
//                            }
//                        }
//                        .pickerStyle(.wheel)
//                        .frame(height: 100)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                        .padding(.horizontal, 20)
//                    }
//                }

                //Height Picker (Show Only on Tap)
                VStack {
                    Text("Height (m)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    ZStack {
                        HStack {
                            Spacer()
                            Text(String(format: "%.2f m", height))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .onTapGesture {
                                    showHeightPicker.toggle()
                                }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        if showHeightPicker {
                            Picker("Height", selection: $height) {
                                ForEach(Array(stride(from: 1.20, through: 2.50, by: 0.01)), id: \.self) { value in
                                    Text(String(format: "%.2f", value))
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 100)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .onChange(of: height) {
                                showHeightPicker = false
                            }
                        }
                    }
                }

                //Weight Picker (Show Only on Tap)
                VStack {
                    Text("Weight (kg)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    ZStack {
                        HStack {
                            Spacer()
                            Text("\(weight) kg")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .onTapGesture {
                                    showWeightPicker.toggle()
                                }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        if showWeightPicker {
                            Picker("Weight", selection: $weight) {
                                ForEach(40...150, id: \.self) { value in
                                    Text("\(value)")
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 100)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .onChange(of: weight) {
                                showWeightPicker = false
                            }
                        }
                    }
                }

                
                
                //Training Goals and Experience Fields
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

                //Preferred Training Days
                VStack {
                    Text("Preferred Training Days")
                        .font(.headline)
                    HStack {
                        ForEach(daysOfWeek, id: \.self) { day in
                            Button(action: {
                                toggleDaySelection(day: day)
                            }) {
                                Text(day.prefix(3))
                                    .padding(8)
                                    .background(selectedDays.contains(day) ? Color.blue : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .center)
                
                //Skill Level Picker (Centered)
                VStack {
                    Text("Skill Level")
                        .font(.headline)
                    Picker("Skill Level", selection: $skillLevel) {
                        ForEach(skillLevels, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .center)

                //Preferred Position Picker
                VStack {
                    Text("Preferred Position")
                        .font(.headline)
                    Picker("Preferred Position", selection: $preferredPosition) {
                        ForEach(preferredPositions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .center)


                //Training Duration Preference Picker
                VStack {
                    Text("Training Duration (mins)")
                        .font(.headline)
                    Picker("Training Duration", selection: $trainingDuration) {
                        ForEach(trainingDurations, id: \.self) { duration in
                            Text("\(duration) mins")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 20)

                //Notification Preference Picker
                VStack {
                    Text("Notification Preference")
                        .font(.headline)
                    Picker("Notification Preference", selection: $notificationPreference) {
                        ForEach(notificationOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .center)

                //Sign Up Button
                Button(action: {
                    //Handle sign-up action
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }

    //Function to toggle selected day
    private func toggleDaySelection(day: String) {
        if selectedDays.contains(day) {
            selectedDays.removeAll { $0 == day }
        } else {
            selectedDays.append(day)
        }
    }

    //Load selected image
    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
