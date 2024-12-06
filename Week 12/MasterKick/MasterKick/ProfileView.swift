////
////  ProfileView.swift
////  MasterKick
////
////  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.
////
//
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
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
                    
                    Button(action: {
                        handleLogOut()
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
//            .navigationBarTitle("Profile", displayMode: .inline)
//            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Log Out") {
//                        handleLogOut()
//                    }
//                }
//            }
            .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Profile")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
//                            ToolbarItem(placement: .navigationBarTrailing) {
//                                Button("Log Out") {
//                                    handleLogOut()
//                                }
//                                .foregroundColor(.red)
//                            }
                        }
        }
    }

    private func handleLogOut() {
        userManager.isLoggedIn = false
        dismiss()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserManager())
    }
}
