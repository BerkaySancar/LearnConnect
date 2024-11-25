//
//  AppCoordinator.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation

enum Route: Hashable {
    case onboarding
    case login
    case signup
    case mainTabBar
    case courseDetail(_ course: Course)
    case videoPlayer(_ course: Course)
}

final class Coordinator: ObservableObject {
    
    @Published var path: [Route] = []
    
    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        self.path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
