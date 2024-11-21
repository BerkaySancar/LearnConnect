//
//  PrimaryActionButton.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import Foundation
import SwiftUI

struct CustomButton: View {
    let imageName: String?
    let buttonText: String
    let action: () -> Void
    let imageTint: Color?
    let width: CGFloat
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if let imageName, let imageTint {
                    Image(systemName: imageName)
                        .foregroundStyle(imageTint)
                }
                Text(buttonText)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(width: width)
        .foregroundStyle(.white)
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        .background(RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(.appGreen))
    }
}
