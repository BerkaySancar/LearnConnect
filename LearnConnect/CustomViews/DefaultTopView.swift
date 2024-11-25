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
            LinearGradient(colors: [.appGreen, .linearGreen],
                           startPoint: .top,
                           endPoint: .bottom)
                .clipShape(RoundedCornersShape(radius: 24, corners: [.bottomLeft, .bottomRight]))
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
    }
}

struct RoundedCornersShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    DefaultTopView(title: "Settings")
}
