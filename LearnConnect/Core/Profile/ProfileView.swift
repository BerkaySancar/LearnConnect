//
//  ProfileView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            DefaultTopView(title: "Profile")
            
            Spacer()
        }
    }
}

#Preview {
    ProfileView()
}
