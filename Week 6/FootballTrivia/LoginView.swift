//
//  LoginView.swift
//  FootballTrivia
//
//  Created by Muhammad Ali Asgar Fataymamode on 18/10/2024.
//


import SwiftUI

struct LoginView: View {
    @AppStorage("username") var username: String = ""
    @State private var enteredUsername: String = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()

                TextField("Enter Username", text: $enteredUsername)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                Button(action: {
                    if !enteredUsername.isEmpty {
                        username = enteredUsername
                        isLoggedIn = true
                    }
                }) {
                    Text("Login")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Spacer()
            }
            .padding()
            .background(
                NavigationLink(destination: ContentView(), isActive: $isLoggedIn) {
                    EmptyView()
                }.hidden()
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
