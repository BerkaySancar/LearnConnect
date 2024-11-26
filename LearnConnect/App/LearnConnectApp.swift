//
//  LearnConnectApp.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging
import UserNotifications

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

//MARK: - AppDelegate

@MainActor
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  let gcmMessageIDKey = "gcm.message_id"

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication
                     .LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    // [START set_messaging_delegate]
    Messaging.messaging().delegate = self
    // [END set_messaging_delegate]

    // Register for remote notifications. This shows a permission dialog on first run, to
    // show the dialog at a more appropriate time move this registration accordingly.
    // [START register_for_notifications]

    UNUserNotificationCenter.current().delegate = self

    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(
      options: authOptions,
      completionHandler: { _, _ in }
    )

    application.registerForRemoteNotifications()

    // [END register_for_notifications]

    return true
  }

  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)
  }

  // [START receive_message]
  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
    -> UIBackgroundFetchResult {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)

    return UIBackgroundFetchResult.newData
  }

  // [END receive_message]

  func application(_ application: UIApplication,
                   didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Unable to register for remote notifications: \(error.localizedDescription)")
  }

  // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
  // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
  // the FCM registration token.
  func application(_ application: UIApplication,
                   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("APNs token retrieved: \(deviceToken)")

    // With swizzling disabled you must set the APNs token here.
    // Messaging.messaging().apnsToken = deviceToken
  }
}

// [START ios_10_message_handling]

extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // [START_EXCLUDE]
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    // [END_EXCLUDE]

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
        return [[.list, .sound]]
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse) async {
    let userInfo = response.notification.request.content.userInfo

    // [START_EXCLUDE]
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    // [END_EXCLUDE]

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)
  }
}

// [END ios_10_message_handling]

extension AppDelegate: MessagingDelegate {
  // [START refresh_token]
    nonisolated func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")

    let dataDict: [String: String] = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: dataDict
    )
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
  }

  // [END refresh_token]
}
