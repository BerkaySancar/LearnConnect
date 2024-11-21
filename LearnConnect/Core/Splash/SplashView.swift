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
        VStack {
            Text("LearnConnect")
                .font(.title.italic())
        }
        .onAppear {
            viewModel.splashAction { route in
                switch route {
                case .login:
                    self.coordinator.push(.login)
                case .mainTabBar:
                    self.coordinator.push(.mainTabBar)
                }
            }
        }
        .alert(isPresented: $viewModel.presentNetworkAlert) {
            Alert(
                title: Text("No internet connection."),
                message: Text("Please check your connection to see updated content."),
                dismissButton: .cancel(Text("Done"), action: { } ))
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(Coordinator())
}
