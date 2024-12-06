//
//  AboutView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("About MasterKick")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                Text("MasterKick is a football training tracker app designed to help you achieve your football goals. Whether you're working on shooting, dribbling, or passing, MasterKick helps you stay on track with detailed stats, goals, and a supportive community. Developed by Muhammad Ali Asgar Fataymamode.")
                    .font(.body)
                    .padding()

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Features:")
                        .font(.headline)

                    Text("• Track your training progress with detailed stats.")
                    Text("• Set personalized training goals.")
                    Text("• Join a community of football enthusiasts.")
                    Text("• View training insights and performance history.")
                }
                .padding()

                Spacer()
            }
            .padding()
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
