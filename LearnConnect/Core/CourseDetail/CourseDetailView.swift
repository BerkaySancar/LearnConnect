//
//  CourseDetailView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 23.11.2024.
//

import SwiftUI
import AVKit

struct CourseDetailView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    @ObservedObject private var viewModel: CourseDetailVM
    
    init(course: Course) {
        self._viewModel = ObservedObject(wrappedValue: CourseDetailVM(course: course))
      }
        
    var isJoined: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                ThumbnailView(geometry: geometry)
                    .onTapGesture {
                        if isJoined {
                            coordinator.push(.videoPlayer(viewModel.course.video))
                        }
                    }
                ScrollView(.vertical) {
                    InformationsView()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                BottomButtonsView()
            }
            .background(.appBackground)
        }
    }
}

//MARK: - UI Elements Extension
extension CourseDetailView {
    @ViewBuilder
    private func ThumbnailView(geometry: GeometryProxy) -> some View {
        ZStack {
            AsyncImage(url: URL(string: viewModel.course.thumbnail)!) { image in
                image
                    .resizable()
                    .cornerRadius(16)
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.gray)
            }
            
            Image(systemName: isJoined ? "play.fill": "play.slash.fill")
                .font(.system(size: 48))
                .foregroundStyle(.white)
        }
        .ignoresSafeArea(edges: .top)
        .frame(width: geometry.size.width, height: geometry.size.height / 3)
    }
    
    @ViewBuilder
    private func InformationsView() -> some View {
        VStack(alignment: .leading) {
            Text(viewModel.course.name)
                .font(.title)
            
            Text(viewModel.course.instructor)
            
            Text(viewModel.course.description)
                .padding(.top, 16)
                .font(.subheadline)
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }
    
    @ViewBuilder
    private func BottomButtonsView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if !isJoined {
                CustomButton(
                    imageName: "plus",
                    buttonText: "Join the Course",
                    action: {
                        
                    },
                    imageTint: .white
                )
            }
            
            CustomButton(
                imageName: "heart",
                buttonText: "Add favorite the course",
                action: {
                    
                },
                imageTint: .white
            )
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    CourseDetailView(course: .example)
}
