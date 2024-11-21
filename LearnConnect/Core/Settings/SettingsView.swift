//
//  SettingsView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            Text("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
