//
//  DefaultTopView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 23.11.2024.
//

import SwiftUI

struct DefaultTopView: View {
    
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(colors: [.appGreen, .linearGreen],
                                     startPoint: .top,
                                     endPoint: .bottom))
                .ignoresSafeArea(edges: .top)
                .frame(height: 60)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
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
    DefaultTopView(title: "Settings")
}
