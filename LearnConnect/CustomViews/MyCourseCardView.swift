//
//  MyCourseCardView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 26.11.2024.
//

import SwiftUI

struct MyCourseCardView: View {
    
    var enrolledCourse: EnrolledCourses
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
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
                Text(enrolledCourse.name ?? "")
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

//#Preview {
//    MyCourseCardView(enrolledCourse: "", viewModel: "")
//}
