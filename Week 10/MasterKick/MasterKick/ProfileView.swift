//
//  ProfileView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.
//


import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                //Profile Picture and Name
                VStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding()
                    
                    Text("User: Asgar Fataymamode")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Position: Striker | Skill Level: Advanced")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Divider()
                
                //Performance Summary
                VStack(alignment: .leading, spacing: 10) {
                    Text("Overall Performance Summary")
                        .font(.headline)
                    
                    HStack {
                        VStack {
                            Text("50")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Training Hours")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack {
                            Text("100")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Dribbling Drills")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack {
                            Text("90%")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Pass Accuracy")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Divider()
                
//                //Training Goals
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Training Goals")
//                        .font(.headline)
//                    
//                    VStack(alignment: .leading) {
//                        Text("Current Goal: Improve shooting accuracy")
//                            .padding(.vertical, 5)
//                        Text("Completed Goal: Reach 100 successful passes")
//                            .foregroundColor(.gray)
//                            .padding(.vertical, 5)
//                        Text("Completed Goal: Run 5k under 20 mins")
//                            .foregroundColor(.gray)
//                            .padding(.vertical, 5)
//                    }
//                }
//                .padding(.horizontal, 20)
//                
//                Divider()
                
                //Account Settings
                VStack(alignment: .leading, spacing: 10) {
                    Text("Account Settings")
                        .font(.headline)
                    
                    Button(action: {
                    }) {
                        Text("Edit Profile")
                    }
                    .padding(.vertical, 5)
                    
                    Button(action: {
                    }) {
                        Text("Notification Settings")
                    }
                    .padding(.vertical, 5)
                    
                    Button(action: {
                    }) {
                        Text("Privacy & Security")
                    }
                    .padding(.vertical, 5)
                }
                .padding(.horizontal, 20)
                
                Divider()
                
                //Logout Button
                Button(action: {
                }) {
                    Text("Log Out")
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
