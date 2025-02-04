//
//  SearchView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 23.11.2024.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                TopSearchView()
                
                if viewModel.courses.isEmpty {
                    if viewModel.searchText.isEmpty {
                        EmptyContentView(
                            systemImage: "magnifyingglass",
                            title: "Search",
                            description: "Search for a course to start learning"
                        )
                    } else {
                        EmptyContentView(
                            systemImage: "xmark.circle",
                            title: "No Results Found",
                            description: "We couldn't find any courses matching \n \"\(viewModel.searchText)\""
                        )
                    }
                } else {
                    ContentView(geometry: geometry)
                }
            }
        }
        .background(.appBackground)
    }
}

//MARK: - UI Elements Extension
extension SearchView {
    
    @ViewBuilder
    private func TopSearchView() -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(colors: [.appGreen, .linearGreen],
                                     startPoint: .top,
                                     endPoint: .bottom))
                .ignoresSafeArea(edges: .top)
                .frame(height: 160)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Search")
                    .foregroundStyle(.white)
                    .font(.title2).bold()
                    .padding(.leading, 16)
                    .padding(.top, 52)
                    .padding(.bottom, 8)
                CustomSearchBarView(text: $viewModel.searchText, searchDisabled: false)
            }
        }
        .frame(height: 50)
    }
    
    @ViewBuilder
    private func ContentView(geometry: GeometryProxy) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.courses) { course in
                    CourseCardView(course: course) { isFav in
                        viewModel.favTapped(course: course, isFavorite: isFav)
                    }
                    .onTapGesture {
                        coordinator.push(.courseDetail(course))
                    }
                    .frame(width: geometry.size.width - 32, height: 230)
                    .padding(.top, 16)
                }
            }
        }
        .padding(.top, 54)
    }
}

#Preview {
    SearchView()
}
