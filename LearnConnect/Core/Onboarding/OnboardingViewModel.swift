//
//  OnboardingViewModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 22.11.2024.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    
    @Published var currentPage = 0
    
    let onboardingData = [
         OnboardingModel(imageName: "graduationcap.fill", title: "Discover Learning", description: "Gain new skills and learn from experts."),
         OnboardingModel(imageName: "books.vertical.fill", title: "Rich Course Content", description: "Achieve your goals with comprehensive courses."),
         OnboardingModel(imageName: "star.fill", title: "Unlock Your Potential", description: "Empower yourself to achieve greatness and make an impact.")
     ]
    
    func nextTapped(completion: () -> Void) {
        if currentPage < onboardingData.count - 1 {
            currentPage += 1
        } else {
            completion()
        }
    }
}
