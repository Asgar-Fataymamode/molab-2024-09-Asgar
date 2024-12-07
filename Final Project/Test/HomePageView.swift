//
//  HomePageView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//




import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var isGetStartedClicked = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("MasterKick")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                Text("Master Every Kick, Reach Every Goal")
                    .font(.headline)
                    .foregroundColor(.blue)

                Spacer()

                if !isGetStartedClicked {
                    Button(action: {
                        isGetStartedClicked = true
                    }) {
                        Text("Get Started")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                } else {
                    
                    if userManager.isLoggedIn {
                        NavigationLink(destination: DashboardView(), isActive: .constant(true)) {
                            EmptyView()
                        }
                        .hidden()
                    } else {
                        VStack(spacing: 15) {
                            NavigationLink(destination: SignInView()) {
                                Text("Sign In")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 30)

                            NavigationLink(destination: SignUpView()) {
                                Text("Sign Up")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
        .onAppear {
            if userManager.isLoggedIn {
                isGetStartedClicked = true
            }
        }
    }
}
