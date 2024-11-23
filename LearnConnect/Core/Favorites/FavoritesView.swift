//
//  FavoritesView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var viewModel = FavoritesViewModel()
    
    @State private var isPresentedDeleteAllConfirm = false
    
    var courses: [Course] = [
//                  Course(title: "SwiftUI Essentials", imageName: "swift"),
//                  Course(title: "Mastering Combine", imageName: "combine"),
//                  Course(title: "iOS Animations", imageName: "animation"),
//                  Course(title: "CoreData Deep Dive", imageName: "coredata")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack {
                    DefaultTopView(title: "Favorites")
                    HStack {
                        Spacer()
                        if !courses.isEmpty {
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
                }
                
                if courses.isEmpty {
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
                ForEach(courses) { course in
                    CourseCardView(course: course)
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
