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
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                DefaultTopView(title: "Profile")
                ScrollView {
                    UserInfoView()
                    
                    CourseStatusView()
                    
                    if !viewModel.enrolledCourses.isEmpty {
                        MyCoursesView()
                    }
                    Spacer()
                }
            }
            .onAppear {
                viewModel.getEnrolledCourses()
            }
            .padding(.bottom, 70)
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
                Text(viewModel.currentUser?.name ?? "")
                    .font(.title2.bold())
                Text(verbatim: viewModel.currentUser?.email ?? "")
                    .font(.callout)
            }
            .foregroundStyle(darkMode ? .white : .black)
            
            Spacer()
        }
        .padding([.horizontal])
        .padding(.vertical, 12)
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
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    VStack(spacing: 12) {
                        Text("Enrolled Courses")
                            .font(.headline)
                        
                        Text("\(viewModel.enrolledCourseCount)")
                            .font(.title2)
                    }
                    .padding(.leading, 36)
                    
                    Spacer()
                    
                    VStack(spacing: 12) {
                        Text("Completed Courses")
                            .font(.headline)
                        
                        Text("\(viewModel.completedCourseCount)")
                            .font(.title2)
                    }
                    
                    Spacer()
                }
                .padding(.top, 16)
                
                HStack(spacing: 0) {
                    if viewModel.enrolledCourseCount < 1 {
                        SimpleDonutChart(completed: 0.01,
                                         total: 0.01
                        )
                        .padding(.leading, 100)
                    } else {
                        SimpleDonutChart(completed: Double(viewModel.completedCourseCount),
                                         total: Double(viewModel.enrolledCourseCount)
                        )
                        .padding(.leading, 100)
                    }
                    VStack {
                        Text(viewModel.progressPercentage <= 1 ? "%0" : "%\(viewModel.progressPercentage)")
                            .font(.title).bold()
                        Text("Progress")
                    }
                    .padding(.trailing, 100)
                }
            }
        }
    }
    
    @ViewBuilder
    private func MyCoursesView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("My Courses")
                .font(.title3.bold())
                .foregroundStyle(darkMode ? .white : .black)
                .padding(.leading, 16)
            
            LazyVStack {
                ForEach(viewModel.enrolledCourses, id: \.self) { enrolledCourse in
                    HStack {
                        AsyncImage(url: .init(string: enrolledCourse.thumbnail ?? "")) { image in
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
                                    .frame(width: 140, height: 100)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(enrolledCourse.courseName ?? "")
                                .font(.headline)
                                .padding(.bottom, 16)
                            
                            ProgressView(
                                "\(viewModel.calculateProgress(for: enrolledCourse))% Complete",
                                value: max(enrolledCourse.videoCurrentTime, 0.01),
                                total: max(enrolledCourse.videoDuration, 100)
                            )
                            .tint(.appGreen)
                        }
                    }
                    .padding(.top, 16)
                    .padding(.trailing, 12)
                    .padding(.leading, 16)
                }
            }
        }
        .padding(.top, 12)
    }
}
