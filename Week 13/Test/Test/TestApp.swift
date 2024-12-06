//
//  TestApp.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//




import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var userManager = UserManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userManager) 
        }
    }
}
