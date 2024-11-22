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
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.title2.bold())
                .foregroundStyle(.appGreen)
                .padding(.bottom, 40)

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
                }
            }
            .confirmationDialog("Are you sure?", isPresented: $isPresentedSignOutConfirm) {
                Button("Sign Out", role: .destructive) {
                    self.loggedInUserID = ""
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
        .padding()
    }
}

#Preview {
    SettingsView()
}
