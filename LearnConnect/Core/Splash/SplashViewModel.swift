//
//  SplashViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation
import SystemConfiguration

enum SplashRoute {
    case login
    case mainTabBar
}

final class SplashViewModel: ObservableObject {
    
    @Published var presentNetworkAlert = false
    
    func splashAction(completion: @escaping ((SplashRoute) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            if self.networkReachability() {
                completion(.login)
            } else {
                self.presentNetworkAlert.toggle()
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
