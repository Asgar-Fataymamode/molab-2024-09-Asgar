//
//  SignInView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.
//
//
//import SwiftUI
//
//struct SignInView: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Sign In")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding(.top, 50)
//
//            TextField("Username", text: $username)
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(10)
//                .padding(.horizontal, 20)
//
//            SecureField("Password", text: $password)
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(10)
//                .padding(.horizontal, 20)
//
//            Button(action: {
//            }) {
//                Text("Sign In")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal, 20)
//
//            Spacer()
//        }
//        .navigationBarTitle("", displayMode: .inline)
//    }
//}
//
//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}




import SwiftUI

struct SignInView: View {
    @EnvironmentObject var userManager: UserManager  // Access the user manager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showDashboard: Bool = false
    @State private var showError: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign In")
                .font(.largeTitle)
                .fontWeight(.bold)

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

            Button(action: {
                if userManager.authenticate(username: username, password: password) {
                    showDashboard = true
                } else {
                    showError = true
                }
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text("Invalid credentials. Please try again."), dismissButton: .default(Text("OK")))
            }

            // Navigation to Dashboard after successful login
            NavigationLink("", destination: DashboardView(), isActive: $showDashboard)
        }
        .padding()
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(UserManager())  // Inject UserManager for preview
    }
}
