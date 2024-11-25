//
//  CategoryCoursesView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 25.11.2024.
//

import SwiftUI

struct CategoryCoursesView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel: CategoryCoursesVM
    
    @State private var isVisible: Bool = true
    
    init(courses: [Course], category: String) {
        self._viewModel = StateObject(wrappedValue: CategoryCoursesVM(courses: courses, category: category))
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                TopView()
                ScrollView {
                    ContentView(geometry: geometry)
                }
            }
            .background(.appBackground)
            .transition(.move(edge: .top))
        }
        .toolbar(.hidden)
        .opacity(isVisible ? 1 : 0.25)
    }
}

// MARK: UI Elements Extension
extension CategoryCoursesView {
    
    @ViewBuilder
    private func TopView() -> some View {
        ZStack {
            DefaultTopView(title: viewModel.category)
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        isVisible = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        coordinator.pop()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .bold()
                }
            }
            .padding(.trailing, 26)
            .padding(.top, 16)
        }
    }
    
    @ViewBuilder
    private func ContentView(geometry: GeometryProxy) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.categoryCourses) { course in
                    CourseCardView(course: course) { isFav in
                        viewModel.favTapped(course: course, isFavorite: isFav)
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
    CategoryCoursesView(courses: [.example], category: "Design")
}
