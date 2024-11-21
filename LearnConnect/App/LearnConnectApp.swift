//
//  LearnConnectApp.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

@main
struct LearnConnectApp: App {
    
    @StateObject private var coordinator: Coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                SplashView()
                    .environmentObject(self.coordinator)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                            LoginView()
                                .navigationBarBackButtonHidden()
                                .environmentObject(self.coordinator)
                        case .signup:
                            SignUpView()
                                .navigationBarBackButtonHidden()
                                .environmentObject(self.coordinator)
                        case .mainTabBar:
                            EmptyView()
                        }
                    }
            }
        }
    }
}
