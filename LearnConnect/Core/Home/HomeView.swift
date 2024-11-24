//
//  HomeView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var coordinator: Coordinator
    @AppStorage("isDarkMode") private var darkMode = false
    
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
                    Text("Hi Berkay,")
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
                .font(.title3).bold()
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(500))], spacing: 0) {
                    ForEach(viewModel.courses) { course in
                        VStack {
                            CourseCardView(course: course)
                                .padding(.leading, 16)
                                .frame(width: geometry.size.width / 1.34, height: 220)
                                .onTapGesture {
                                    coordinator.push(.courseDetail(course))
                                }
                        }
                    }
                }
            }
            .scrollIndicators(.never, axes: .horizontal)
            .frame(height: 260)
        }
        .padding(.top, 16)
    }
    
    
    @ViewBuilder
    private func CategorySliderView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Category")
                .font(.title3).bold()
                .padding(.horizontal, 16)
             
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible(minimum: 1))], spacing: 16) {
                    ForEach(0...5, id: \.self) { category in
                        Button {
                            
                        } label : {
                            VStack {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .padding(.bottom, 16)
                                
                                Text("Design")
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
