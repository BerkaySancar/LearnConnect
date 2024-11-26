//
//  SplashViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation
import SystemConfiguration


final class SplashViewModel: ObservableObject {
    
    @Published var presentNetworkAlert = false
    @Published var splashRoute: SplashRoute? = nil
    
    func splashAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            if Reachability.isNetworkReachable() == false {
                presentNetworkAlert.toggle()
            } else {
                setRoute()
            }
        }
    }
    
    func setRoute() {
        if CurrentUserService.shared.getCurrentUser() != nil {
            self.splashRoute = .mainTabBar
        } else {
            self.splashRoute = .onboarding
        }
    }
}

enum SplashRoute {
    case onboarding
    case mainTabBar
}
