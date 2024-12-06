//
//  ProfileView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//


import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding()

                if let user = userManager.currentUser {
                    Text("User: \(user.username)")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Email: \(user.email)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Divider()
                
                
                NavigationLink(destination: EditProfileView()) {
                    Text("Edit Profile")
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

                
                NavigationLink(destination: AboutView()) {
                    Text("About")
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

                NavigationLink(destination: RulesAndRegulationsView()) {
                    Text("Rules & Regulations")
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

                NavigationLink(destination: SettingsView()) {
                    Text("Settings")
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

                Divider()

                Button(action: {
                    userManager.logout()
                    dismiss()
                }) {
                    Text("Log Out")
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserManager())
    }
}
