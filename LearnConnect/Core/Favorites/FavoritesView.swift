//
//  FavoritesView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = FavoritesViewModel()
    
    @State private var isPresentedDeleteAllConfirm = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    DefaultTopView(title: "Favorites")
                    HStack {
                        Spacer()
                        if !viewModel.courses.isEmpty {
                            Button {
                                isPresentedDeleteAllConfirm.toggle()
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                            .confirmationDialog("Are you sure want to delete all favorites?", isPresented: $isPresentedDeleteAllConfirm, titleVisibility: .visible) {
                                Button("Delete All", role: .destructive) {
                                    
                                }
                            }
                        }
                    }
                    .padding(.trailing, 26)
                    .padding(.top, 16)
                }
                
                if viewModel.courses.isEmpty {
                    EmptyContentView(
                        systemImage: "heart.slash.fill",
                        title: "No Favorites Yet",
                        description: "Find courses you love and add them to your favorites!"
                    )
                    .padding()
                } else {
                    ContentView(geometry: geometry)
                }
       
                Spacer()
            }
            .onAppear {
                viewModel.getCourses()
            }
            .background(.appBackground)
        }
    }
}

// MARK: - UI Elements Extension
extension FavoritesView {
    @ViewBuilder
    private func ContentView(geometry: GeometryProxy) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.courses) { course in
                    CourseCardView(course: course) { _ in
                        viewModel.favTapped(course: course)
                    }
                    .onTapGesture {
                        coordinator.push(.courseDetail(course))
                    }
                    .frame(width: geometry.size.width - 32, height: 230)
                }
            }
        }
        .padding(.top, 22)
    }
    
}

#Preview {
    FavoritesView()
}
