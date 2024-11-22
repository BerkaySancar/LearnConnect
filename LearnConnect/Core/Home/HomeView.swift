//
//  HomeView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @AppStorage("isDarkMode") private var darkMode = false
    
    @State private var text = ""
    
    var courses: [Course] = [
          Course(title: "SwiftUI Essentials", imageName: "swift"),
          Course(title: "Mastering Combine", imageName: "combine"),
          Course(title: "iOS Animations", imageName: "animation"),
          Course(title: "CoreData Deep Dive", imageName: "coredata")
      ]
        
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
                       
                SearchView()
                    .padding(.top, 16)
                
                }
                .foregroundStyle(.white)
                .font(.title2)
        }
        .frame(height: 154)
    }
    
    @ViewBuilder
    private func SearchView() -> some View {
        ZStack {
            TextField("", text: $text, prompt: Text(" 🔍 Search Course").foregroundColor(.gray)
                .font(.system(size: 16)))
                .textFieldStyle(.plain)
                .padding(.all, 10)
                .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.white))
                .autocorrectionDisabled(true)
                .padding(.leading, 16)
                .padding(.trailing, 16)
        }
    }
  
    @ViewBuilder
    private func ContentView(geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Top Courses")
                .font(.title3).bold()
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(500))], spacing: 0) {
                    ForEach(courses) { course in
                        VStack {
                            CourseCard(geometry: geometry, course: course)
                                .frame(width: geometry.size.width / 1.35, height: 260)
                                .padding(.horizontal)
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
                            //                        viewModel.getCategoryProducts(category: category)
                            //                        viewModel.selectedCategory = category
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
    
    @ViewBuilder
    private func CourseCard(geometry: GeometryProxy, course: Course) -> some View {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    AsyncImage(url: .init(string: "https://images.theconversation.com/files/374729/original/file-20201214-19-dtt9f5.jpg")!) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width / 1.35, height: 170)
                            .clipped()
                            .overlay(
                                Color.black.opacity(0.5)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } placeholder: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.gray)
                                .frame(width: geometry.size.width / 1.35, height: 170)
                        }
                    }
                    
                    Image(systemName: "play.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                       
                        } label: {
                            Image(systemName: "heart")
                                .font(.system(size: 24))
                                .padding()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.appGreen)
                                .background(Capsule().foregroundStyle(.appWhiteText))
                        }
                    }
                    .frame(width: geometry.size.width / 1.4)
                    .offset(y: -55)
                    
                    HStack {
                        Spacer()
                        Button {
                         
                        } label: {
                            Text("Android")
                                .font(.system(size: 16))
                                .padding()
                                .frame(height: 40)
                                .foregroundStyle(.appGreen)
                                .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.appWhiteText))
                        }
                    }
                    .frame(width: geometry.size.width / 1.4)
                    .offset(y: 55)
                }

                Group {
                    Text(course.title)
                        .font(.subheadline)
                        .bold()
                    
                    Text(course.title)
                        .font(.subheadline)
                        .bold()
                }
                .padding(.top, 16)
                .foregroundStyle(darkMode ? .white : .black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct Course: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

#Preview {
    HomeView()
}
