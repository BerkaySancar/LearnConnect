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
    
    @StateObject private var viewModel: CourseDetailVM
    
    init(course: Course) {
        self._viewModel = StateObject(wrappedValue: CourseDetailVM(course: course))
      }
        
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    ThumbnailView(geometry: geometry)
                        .onTapGesture {
                            if viewModel.isJoined {
                                coordinator.push(.videoPlayer(viewModel.course))
                            }
                        }
                    ScrollView(.vertical) {
                        InformationsView()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    BottomButtonsView()
                    
                    Spacer()
                }
                Spacer()
            }
            .background(.appBackground)
            .alert(isPresented: $viewModel.showAlert) {
                switch viewModel.currentAlert {
                case .successAlert:
                    Alert(
                        title: Text("Enrolled Successfully"),
                        message: Text("You have successfully enrolled in the course. You can now start watching and learning!")
                    )
                case .warningAlert:
                    Alert(
                        title: Text("Warning"),
                        message: Text("Are you sure about leaving the course?"),
                        primaryButton: .destructive(Text("Leave")) {
                            viewModel.joinCourseTapped()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
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
            
            Image(systemName: viewModel.isJoined ? "play.fill": "play.slash.fill")
                .font(.system(size: 48))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .frame(width: geometry.size.width, height: 220)
    }
    
    @ViewBuilder
    private func InformationsView() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.course.name)
                .font(.title2.bold())
            
            HStack {
                Text(viewModel.course.instructor)
                Spacer()
                Text(viewModel.course.category)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.orange.opacity(0.80))
                    }
            }
            .padding(.bottom, 4)
            
            Text(viewModel.course.description)
                .padding()
                .font(.callout)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.softGreen)
                }
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }
    
    @ViewBuilder
    private func BottomButtonsView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            CustomButton(
                imageName: viewModel.isJoined ? "person.crop.circle.badge.minus" : "person.crop.circle.badge.plus",
                buttonText: viewModel.isJoined ? "Leave the Course" : "Join the Course",
                buttonType: viewModel.isJoined ? .destructive : .primary,
                action: {
                    if viewModel.isJoined {
                        viewModel.showLeaveWarningAlert()
                    } else {
                        viewModel.joinCourseTapped()
                    }
                },
                imageTint: .white
            )
            
            CustomButton(
                imageName: viewModel.course.isFavorite ? "heart.fill" : "heart",
                buttonText: viewModel.course.isFavorite ? "Remove from Favorites" : "Add to Favorites",
                action: {
                    viewModel.addToFavoriteTapped()
                },
                imageTint: viewModel.course.isFavorite ? .red : .white
            )
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    CourseDetailView(course: .example)
}
