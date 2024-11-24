//
//  ProfileView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 21.11.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage("isDarkMode") private var darkMode = false
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var courses: [Course] = [
                Course(title: "SwiftUI Essentials", imageName: "swift"),
                Course(title: "Mastering Combine", imageName: "combine"),
                Course(title: "iOS Animations", imageName: "animation"),
                Course(title: "CoreData Deep Dive", imageName: "coredata")
    ]
        
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                DefaultTopView(title: "Profile")
                ScrollView {
                    UserInfoView()
                    
                    CourseStatusView()
                    
                    if !courses.isEmpty {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("My Courses")
                                .font(.title3.bold())
                                .foregroundStyle(darkMode ? .white : .black)
                                .padding(.leading, 16)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(courses) { course in
                                        HStack {
                                            AsyncImage(url: .init(string: "https://images.theconversation.com/files/374729/original/file-20201214-19-dtt9f5.jpg")!) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 140, height: 100)
                                                    .overlay(
                                                        Color.black.opacity(0.5)
                                                    )
                                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                            } placeholder: {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .foregroundStyle(.gray)
                                                        .frame(width: 100, height: 100)
                                                }
                                            }
                                            
                                            VStack(alignment: .leading, spacing: 0) {
                                                Text(course.title)
                                                    .font(.headline)
                                                    .padding(.bottom, 4)
                                                Text("Ali Veli")
                                                    .padding(.bottom, 16)
                                                
                                                ProgressView("%30 Complete", value: 30, total: 100)
                                                    .tint(.appGreen)
                                            }
                                        }
                                        .padding(.top, 16)
                                        .padding(.trailing, 12)
                                        .padding(.leading, 16)
                                    }
                                }
                            }
                        }
                        .padding(.top, 16)
                    }
                    
                    Spacer()
                }
            }
            .background(.appBackground)
        }
    }
}

#Preview {
    ProfileView()
}

//MARK: UI Elements Extension
extension ProfileView {
    @ViewBuilder
    private func UserInfoView() -> some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 80)
                    .foregroundStyle(.gray.opacity(0.5))
                
                Image(systemName: "person.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.white)
            }
            
            VStack(alignment: .leading) {
                Text("Berkay Sancar")
                    .font(.title2.bold())
                Text(verbatim: "berkay@mail.com")
                    .font(.callout)
            }
            .foregroundStyle(darkMode ? .white : .black)
            
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    private func CourseStatusView() -> some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 220)
                .padding(.horizontal)
                .foregroundStyle(.softGreen)
            
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 1, height: 80)
                .foregroundStyle(darkMode ? .white : .black)
            
            VStack {
                HStack(spacing: 0) {
                    VStack(spacing: 12) {
                        Text("Enrolled Courses")
                            .font(.headline)
                        
                        Text("3")
                            .font(.title2)
                    }
                    .padding(.leading, 36)
                    
                    Spacer()
                    
                    VStack(spacing: 12) {
                        Text("Total Courses")
                            .font(.headline)
                        
                        Text("5")
                            .font(.title2)
                    }
                    
                    Spacer()
                }
                .padding(.top, 16)
                
                HStack(spacing: 0) {
                    SimpleDonutChart(completed: 1, total: 3)
                        .padding(.leading, 100)
                    
                    VStack {
                        Text("%\(Double(1) / Double(3) * 100, specifier: "%.1f")")
                            .font(.title).bold()
                        Text("Progress")
                    }
                    .padding(.trailing, 100)
                }
            }
        }
    }
}

import Charts

struct SimpleDonutChart: View {
    let completed: Double
    let total: Double
    
    var remaining: Double {
        max(total - completed, 0)
    }
    
    var body: some View {
        Chart {
            SectorMark(
                angle: .value("Completed", completed),
                innerRadius: .ratio(0.5),
                outerRadius: .ratio(1.0)
            )
            .foregroundStyle(.appGreen)
            
            SectorMark(
                angle: .value("Remaining", remaining),
                innerRadius: .ratio(0.5),
                outerRadius: .ratio(1.0)
            )
            .foregroundStyle(.orange)
        }
        .frame(height: 100)
        .padding()
    }
}
