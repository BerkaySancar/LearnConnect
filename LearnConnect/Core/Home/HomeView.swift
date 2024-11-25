//
//  HomeView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("isDarkMode") private var darkMode = false
    @EnvironmentObject private var coordinator: Coordinator
    
    @StateObject private var viewModel = HomeViewModel()
 
    @Binding var selectedTab: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TopView()
                ScrollView(.vertical, showsIndicators: false) {
                    ContentView(geometry: geometry)
                    CategorySliderView()
                }
            }
        }
        .onAppear {
            viewModel.getCourses()
        }
        .background(.appBackground)
    }
}

//MARK: - UI Elements Extension
extension HomeView {
    
    @ViewBuilder
    private func TopView() -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient(colors: [.appGreen, .linearGreen],
                                     startPoint: .top,
                                     endPoint: .bottom))
                .ignoresSafeArea()
                .frame(height: 170)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Hi \(viewModel.currentUser?.name?.capitalized ?? ""),")
                    .padding(.horizontal, 16)
                    .bold()
                    .font(.title)
                
                Text("Let's Start Learning")
                    .padding(.horizontal, 16)
                    .font(.title3)
                    .foregroundStyle(.appWhiteText)
                    .padding(.top, 8)
                
                CustomSearchBarView(text: $viewModel.searchText, searchDisabled: true)
                    .padding(.top, 16)
                    .onTapGesture {
                        selectedTab = 1
                    }
            }
            .foregroundStyle(.white)
            .font(.title2)
        }
        .frame(height: 154)
    }
    
    @ViewBuilder
    private func ContentView(geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Top Courses")
                .font(.title2).bold()
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.courses) { course in
                        VStack {
                            CourseCardView(course: course) { isFav in
                                viewModel.favTapped(course: course, isFavorite: isFav)
                            }
                            .padding(.leading, 16)
                            .frame(width: geometry.size.width / 1.34, height: 260)
                            .onTapGesture {
                                coordinator.push(.courseDetail(course))
                            }
                        }
                    }
                }
            }
            .frame(height: 280)
        }
        .padding(.top, 16)
    }
    
    
    @ViewBuilder
    private func CategorySliderView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Categories")
                .font(.title2).bold()
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible(minimum: 1))], spacing: 16) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Button {
                            coordinator.push(.categoryCourses(viewModel.courses, category.name))
                        } label : {
                            VStack {
                                Image(category.image)
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .padding(.bottom, 16)
                                
                                Text(category.name)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(darkMode ? .white : .black)
                            }
                        }
                        .frame(width: 120, height: 140)
                        .foregroundStyle(.black)
                        .background {
                            RoundedRectangle(cornerRadius: 24)
                                .foregroundStyle(.softGreen)
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(lineWidth: 2)
                                .foregroundStyle(.appGreen)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.never, axes: .horizontal)
            .frame(height: 180)
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(1))
}
