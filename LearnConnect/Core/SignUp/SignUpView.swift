//
//  SignUpView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        InputView()
    }
}

extension SignUpView {
    
    @ViewBuilder
    private func InputView() -> some View {
        VStack {
            Text("Register")
                .font(.title2).bold()
                .foregroundStyle(.gray)
                .padding(.top, 10)
            
            Group {
                TextField("", text: $viewModel.firstName, prompt: Text("First Name"))
                TextField("", text: $viewModel.lastName, prompt: Text("Last Name"))
                TextField("", text: $viewModel.email, prompt: Text("Email"))
                SecureField("", text: $viewModel.password, prompt: Text("Password"))
            }
            .frame(height: 30)
            .modifier(AppTextFieldModifier())
            
            CustomButton(
                imageName: nil,
                buttonText: "Create",
                action: something,
                imageTint: nil,
                width: 100
            )
            .padding(.top)
        
            Button {
                coordinator.pop()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Log in.")
                        .bold()
                }
                .font(.callout)
                .foregroundStyle(.gray)
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
        }
        .padding(.horizontal)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
    
    func something() { }
}

#Preview {
    SignUpView()
}
