//
//  LoginView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 75) {
            TopView()
            InputView()
        }
    }
}

//MARK: - UI Elements Extension
extension LoginView {
    
    @ViewBuilder
    private func TopView() -> some View {
        VStack {
            Image(systemName: "graduationcap.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(.appGreen)
                .padding(.bottom, 16)
            Text("Welcome to")
                .font(.title)
                .foregroundStyle(.appGreen)
            Text("LearnConnect")
                .font(.title.italic())
        }
    }

    @ViewBuilder
    private func InputView() -> some View {
        VStack {
            Group {
                TextField("",
                          text: $viewModel.email,
                          prompt: Text("Username"))
                
                SecureField("",
                            text: $viewModel.password,
                            prompt: Text("Password"))
            }
            .frame(height: 30)
            .modifier(AppTextFieldModifier())
            .padding(.horizontal)
            .padding(.top, 4)
            
            CustomButton(
                imageName: nil,
                buttonText: "Login",
                action: {
                    coordinator.push(.mainTabBar)
                },
                imageTint: nil,
                width: 100
            )
            .padding(.top)
            
            Button {
                coordinator.push(.signup)
            } label: {
                HStack {
                    Text("Don't have an account?")
                    Text("Sign up.")
                        .bold()
                }
                .font(.callout)
                .foregroundStyle(.gray)
            }
            .padding(.top, 10)
        }
    }
}

#Preview {
    LoginView()
}
