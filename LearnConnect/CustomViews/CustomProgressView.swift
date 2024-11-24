//
//  CustomProgressView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import SwiftUI

struct CustomProgressView: View {
    
    @AppStorage("isDarkMode") private var darkMode = false
    
    @Binding var isVisible: Bool
    
    var body: some View {
        if isVisible {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                    .blur(radius: 400)
                VStack {
                    ProgressView()
                        .controlSize(.large)
                        .tint(darkMode ? .white : .black)
                }
                .padding(.all, 12)
            }
            .allowsHitTesting(true)
        }
    }
}

#Preview {
    CustomProgressView(isVisible: .constant(true))
}
