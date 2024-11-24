//
//  CourseCardView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 23.11.2024.
//

import SwiftUI

struct CourseCardView: View {
    
    @AppStorage("isDarkMode") private var darkMode = false
    
    var course: Course
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                ZStack {
                    AsyncImage(url: .init(string: "https://images.theconversation.com/files/374729/original/file-20201214-19-dtt9f5.jpg")!) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: 170)
                            .overlay(
                                Color.black.opacity(0.5)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } placeholder: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.gray)
                                .frame(width: geometry.size.width, height: 170)
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
                    .offset(y: -55)
                    .padding(.trailing, 8)
                    
                    HStack {
                        Spacer()
                        Text("Android")
                            .font(.system(size: 16))
                            .padding()
                            .frame(height: 40)
                            .foregroundStyle(.appGreen)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.appWhiteText))
                    }
                    .offset(y: 55)
                    .padding(.trailing, 8)
                }
                
                Group {
                    HStack {
                        VStack {
                            Text(course.title)
                                .font(.subheadline)
                                .bold()
                            
                            Text(course.title)
                                .font(.subheadline)
                                .bold()
                        }
                        Spacer()
                    }
                }
                .padding(.top, 16)
                .foregroundStyle(darkMode ? .white : .black)
            }
        }
    }
}

#Preview {
    CourseCardView(course:  Course(title: "SwiftUI Essentials", imageName: "swift"))
}
