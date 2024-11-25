//
//  LearnConnectApp.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct LearnConnectApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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
                        case .courseDetail(let course):
                            CourseDetailView(course: course)
                                .environmentObject(self.coordinator)
                        case .videoPlayer(let course):
                            VideoPlayerView(course: course)
                                .navigationBarBackButtonHidden()
                        case .categoryCourses(let courses, let category):
                            CategoryCoursesView(courses: courses, category: category)
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
        UIBarButtonItem.appearance().tintColor = UIColor.appGreen
        UINavigationBar.appearance().standardAppearance = appearance
    }
}
