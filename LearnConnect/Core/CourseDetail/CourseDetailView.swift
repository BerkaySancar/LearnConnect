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
    
    struct CourseModel {
        var id: Int
        var name: String
        var description: String
        var thumbnail: String
        var video: String
    }
    
    var course = CourseModel(
        id: 1,
        name: "SwiftUI",
        description: "ASdasdasda sdaksjdhalkjsdas dasdah skdha skdha skdh aklshd ashjd aksdasd asd asd asd asd asdassss.",
        thumbnail: "https://picsum.photos/200/300",
        video: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    )
    
    var isJoined: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                ThumbnailView(geometry: geometry)
                    .onTapGesture {
                        if isJoined {
                            coordinator.push(.videoPlayer(course.video))
                        }
                    }
                ScrollView(.vertical) {
                    InformationsView()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                BottomButtonsView()
            }
        }
    }
}

//MARK: - UI Elements Extension
extension CourseDetailView {
    @ViewBuilder
    private func ThumbnailView(geometry: GeometryProxy) -> some View {
        ZStack {
            AsyncImage(url: URL(string: course.thumbnail)!) { image in
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
            Text(course.name)
                .font(.title)
            
            Text("Ali Veli")
            
            Text(course.description)
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
    CourseDetailView()
}
