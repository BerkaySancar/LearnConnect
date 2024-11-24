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
    var onFavoriteTapped: ((Bool) -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                ZStack {
                    AsyncImage(url: .init(string: course.thumbnail)!) { image in
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
                            self.onFavoriteTapped?(!course.isFavorite)
                        } label: {
                            Image(systemName: course.isFavorite ? "heart.fill" : "heart")
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
                        Text(course.category)
                            .font(.system(size: 16))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .foregroundStyle(.appGreen)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.appWhiteText))
                    }
                    .offset(y: 55)
                    .padding(.trailing, 8)
                }
                
                Group {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(course.name)
                                .font(.title3)
                                .bold()
                                .lineLimit(2)
            
                            Text(course.instructor)
                                .font(.callout)
                                .foregroundStyle(darkMode ? .white.opacity(0.5) : .black.opacity(0.5))
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
    CourseCardView(course: Course.example)
}
