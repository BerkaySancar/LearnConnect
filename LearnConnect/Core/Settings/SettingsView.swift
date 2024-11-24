//
//  SettingsView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var darkMode: Bool = false
    @AppStorage("loggedInUserID") private var loggedInUserID = ""
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var isPresentedSignOutConfirm: Bool = false
    @State private var isPresentedDeleteAccountConfirm: Bool = false
    
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            DefaultTopView(title: "Settings")

            VStack {
                Group {
                    HStack {
                        Image(systemName: "lightbulb.2")
                            .foregroundColor(.primary)
                        Toggle("Dark Mode", isOn: $darkMode)
                            .tint(.green)
                    }
                    
                    Divider()
                    
                    Button {
                        isPresentedSignOutConfirm.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "iphone.and.arrow.right.inward")
                                .foregroundStyle(.red)
                            
                            Text("Sign Out")
                                .foregroundStyle(.red)
                            
                            Spacer()
                        }
                    }
                    .confirmationDialog("Are you sure?", isPresented: $isPresentedSignOutConfirm) {
                        Button("Sign Out", role: .destructive) {
                            viewModel.signOutTapped()
                            self.coordinator.push(.login) }
                    }
                    
                    Divider()
                    
                    Button {
                        self.isPresentedDeleteAccountConfirm.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "xmark.shield")
                                .foregroundStyle(.red)
                            
                            Text("Delete Account")
                                .foregroundStyle(.red)
                                .bold()
                            
                            Spacer()
                        }
                    }
                    .confirmationDialog("Are you sure?", isPresented: $isPresentedDeleteAccountConfirm) {
                        Button("DELETE ACCOUNT", role: .destructive) {
                            viewModel.deleteAccountBy(id: self.loggedInUserID)
                            self.loggedInUserID = ""
                            self.coordinator.push(.login)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                VStack(alignment: .center) {
                    Text("Version 1.0.0")
                    Text("© Copyright Berkay Sancar © \n All rights reserved.")
                        .multilineTextAlignment(.center)
                }
                .font(.caption)
                .padding(.bottom, 100)
            }
            .padding(.top, 32)
        }
        .background(.appBackground)
    }
}

//MARK: - UI Elements Extension
extension SettingsView {
    
    @ViewBuilder
    private func TopView() -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(colors: [.appGreen, .linearGreen],
                                     startPoint: .top,
                                     endPoint: .bottom))
                .ignoresSafeArea(edges: .top)
                .frame(height: 60)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Settings")
                    .foregroundStyle(.white)
                    .font(.title2).bold()
                    .padding(.leading, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
            }
        }
        .frame(height: 50)
    }
    
}

#Preview {
    SettingsView()
}
