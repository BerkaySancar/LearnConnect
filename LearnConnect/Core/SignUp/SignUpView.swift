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
        VStack(spacing: 20) {
            TopView()
                .padding(.top, 20)
            InputView()
            Spacer()
        }
        .alert(isPresented: $viewModel.showAlert) {
            switch viewModel.activeAlert {
            case .signUpSuccess:
                Alert(
                    title: Text(SignUpAlert.signUpSuccess.title),
                    message: Text(SignUpAlert.signUpSuccess.message),
                    dismissButton: .cancel(Text("OK"), action: {
                        coordinator.pop()
                    })
                )
            case .signUpFailure:
                Alert(title: Text(SignUpAlert.signUpFailure.title),
                      message: Text(SignUpAlert.signUpFailure.message))
            }
        }
    }
}

//MARK: - UI Elements Extension
extension SignUpView {
    
    @ViewBuilder
    private func TopView() -> some View {
        VStack {
            Image(systemName: "graduationcap.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(.appGreen)
                .padding(.bottom, 16)
            Text("Register for")
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
                TextField("", text: $viewModel.firstName, prompt: Text("First Name"))
                TextField("", text: $viewModel.lastName, prompt: Text("Last Name"))
                TextField("", text: $viewModel.email, prompt: Text("Email"))
                SecureField("", text: $viewModel.password , prompt: Text("Password"))
            }
            .frame(height: 30)
            .modifier(AppTextFieldModifier())
            .padding(.top, 4)
            
            CustomButton(
                imageName: nil,
                buttonText: "Sign Up",
                action: viewModel.signUpTapped,
                imageTint: nil,
                width: 100
            )
            .padding(.top)
            
            Spacer()
        
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
}

#Preview {
    SignUpView()
}
