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
            Image(systemName: "graduationcap.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(.appGreen)
                .padding(.bottom, 16)
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
