//
//  CourseDetailVM.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

final class CourseDetailVM: ObservableObject {
    
    var course: Course
    
    init(course: Course) {
        self.course = course
    }
}
