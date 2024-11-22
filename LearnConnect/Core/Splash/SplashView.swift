//
//  ContentView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @AppStorage("loggedInUserID") private var loggedInUserID = ""
    
    @StateObject private var viewModel = SplashViewModel()

    var body: some View {
        VStack {
            Image(systemName: "graduationcap.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(.appGreen)
                .padding(.bottom, 16)
            Text("LearnConnect")
                .font(.title.italic())
        }
        .onAppear {
            self.viewModel.isAuthorized = self.loggedInUserID != ""
            viewModel.splashAction()
        }
        .onChange(of: viewModel.splashRoute) { route in
            guard let route else { return }
            switch route {
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
                    viewModel.splashAction()
                })
            )
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(Coordinator())
}
