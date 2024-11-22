//
//  TextField+Modifier.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation
import SwiftUI

struct AppTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.all, 8)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.appGreen)
            }
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.15)))
    }
}
