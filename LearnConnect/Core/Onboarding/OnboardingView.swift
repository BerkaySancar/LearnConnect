//
//  OnboardingView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 22.11.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentPage) {
                ForEach(0..<viewModel.onboardingData.count, id: \.self) { index in
                    OnboardingPageView(page: viewModel.onboardingData[index])
                        .tag(index)
                }
            }
            
            CustomButton(
                imageName: nil,
                buttonText: viewModel.currentPage == viewModel.onboardingData.count - 1 ? "Start" : "Next",
                action: { viewModel.nextTapped { self.coordinator.push(.login) }},
                imageTint: nil
            )
            .padding(.bottom, 20)
            .padding(.horizontal)
        }
    }
}

//MARK: - Onboarding Page View
struct OnboardingPageView: View {
    let page: OnboardingModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: page.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.appGreen)
            
            Text(page.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
