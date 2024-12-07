//
//  SettingsView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("enableNotifications") private var enableNotifications = true
    @AppStorage("darkMode") private var darkMode = false
    @AppStorage("soundEffects") private var soundEffects = true

    var body: some View {
        Form {
            Section(header: Text("Preferences")) {
                Toggle(isOn: $enableNotifications) {
                    Text("Enable Notifications")
                }

                Toggle(isOn: $darkMode) {
                    Text("Dark Mode")
                }

                Toggle(isOn: $soundEffects) {
                    Text("Sound Effects")
                }
            }

            Section(header: Text("App Information")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0").foregroundColor(.gray)
                }

                HStack {
                    Text("Developer")
                    Spacer()
                    Text("Asgar Fataymamode").foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
