//
//  ContentView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    @StateObject private var viewModel = SplashViewModel()

    var body: some View {
        ZStack {
            LinearGradient(colors: [.appGreen, .linearGreen], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "graduationcap.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)
                    .padding(.bottom, 16)
                Text("LearnConnect")
                    .font(.title.italic())
                    .foregroundStyle(.white)
                    .bold()
            }
            .onAppear {
                viewModel.splashAction()
            }
            .onChange(of: viewModel.splashRoute) { _, new in
                guard let new else { return }
                switch new {
                case .onboarding:
                    coordinator.push(.onboarding)
                case .mainTabBar:
                    coordinator.push(.mainTabBar)
                }
            }
            .alert(isPresented: $viewModel.presentNetworkAlert) {
                Alert(
                    title: Text("No Internet Connection"),
                    message: Text("Please connect to the internet to see updated content."),
                    dismissButton: .cancel(Text("OK"), action: {
                        viewModel.setRoute()
                    })
                )
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(Coordinator())
}
