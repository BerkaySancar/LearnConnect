//
//  EmptyContentView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 23.11.2024.
//

import SwiftUI

struct EmptyContentView: View {
    
    var systemImage: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: systemImage)
                .font(.title)
            Text(title)
                .font(.headline)
            Text(description)
                .font(.callout)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

#Preview {
    EmptyContentView(systemImage: "magnifyingglass",title: "Content failure", description: "Sonuç bulunamadı.")
}
