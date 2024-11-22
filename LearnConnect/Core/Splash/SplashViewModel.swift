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
    
    @Published var isAuthorized: Bool = false
    @Published var splashRoute: SplashRoute? = nil
    
    func splashAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            if self.networkReachability() == false {
                presentNetworkAlert.toggle()
            } else if isAuthorized {
                self.splashRoute = .mainTabBar
            } else {
                self.splashRoute = .onboarding
            }
        }
    }
 
    private func networkReachability() -> Bool {
        if let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") {
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            
            return flags.contains(.reachable) && !flags.contains(.connectionRequired)
        }
        return false
    }
}

enum SplashRoute {
    case onboarding
    case mainTabBar
}
