//
//  LearnConnectApp.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

@main
struct LearnConnectApp: App {
    
    @AppStorage("isDarkMode") private var darkMode = false
    @StateObject private var coordinator: Coordinator = Coordinator()
    
    init() {
        navBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                SplashView()
                    .environmentObject(self.coordinator)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .onboarding:
                            OnboardingView()
                                .navigationBarBackButtonHidden()
                                .environmentObject(self.coordinator)
                        case .login:
                            LoginView()
                                .navigationBarBackButtonHidden()
                                .environmentObject(self.coordinator)
                        case .signup:
                            SignUpView()
                                .navigationBarBackButtonHidden()
                                .environmentObject(self.coordinator)
                        case .mainTabBar:
                            MainTabbarView()
                                .navigationBarBackButtonHidden()
                                .environmentObject(self.coordinator)
                        case .courseDetail:
                            CourseDetailView()
                                .environmentObject(self.coordinator)
                        }
                    }
            }
            .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
    
    private func navBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.appGreen]
        UIBarButtonItem.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
    }
}
