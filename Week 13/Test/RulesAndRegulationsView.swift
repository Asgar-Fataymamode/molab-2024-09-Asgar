//
//  RulesAndRegulationsView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//

import SwiftUI

struct RulesAndRegulationsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Rules and Regulations")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                Text("By using MasterKick, you agree to adhere to the following rules and regulations:")
                    .font(.body)
                    .padding()

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text("1. Age Requirement:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("You must be at least 13 years old to use this application.")
                        .font(.body)

                    Text("2. Account Security:")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("Keep your login credentials secure and do not share them with others.")
                        .font(.body)

                    Text("3. Respectful Conduct:")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("Engage with the community respectfully. Avoid inappropriate language or behavior.")
                        .font(.body)

                    Text("4. Privacy Policy:")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("Your data is stored securely and is not shared with third parties without your consent.")
                        .font(.body)

                    Text("5. Compliance:")
                        .font(.headline)
                        .padding(.top, 10)
                    Text("Failure to adhere to these rules may result in account suspension or termination.")
                        .font(.body)
                }
                .padding()

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Rules & Regulations")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RulesAndRegulationsView_Previews: PreviewProvider {
    static var previews: some View {
        RulesAndRegulationsView()
    }
}
