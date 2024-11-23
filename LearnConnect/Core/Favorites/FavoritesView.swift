//
//  FavoritesView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        VStack {
            DefaultTopView(title: "Favorites")
            
            Spacer()
        }
    }
}

#Preview {
    FavoritesView()
}
