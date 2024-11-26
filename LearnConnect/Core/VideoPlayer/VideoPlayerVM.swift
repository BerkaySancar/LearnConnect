//
//  VideoPlayerVM.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 25.11.2024.
//

import Foundation

final class VideoPlayerViewModel: ObservableObject {
    
    private let enrolledCoursesService: EnrolledCoursesService
    
    @Published var course: Course
    @Published var lastVideoTime: Double = 0.0
    
    var isVideoFinished: Bool = false {
        didSet {
            setVideoCompletion()
        }
    }
    
    init(course: Course, enrolledCoursesService: EnrolledCoursesService = .shared) {
        self.course = course
        self.enrolledCoursesService = enrolledCoursesService
        getVideoCurrentTime()
    }
    
    func getVideoCurrentTime() {
        let enrolledCourse = enrolledCoursesService.getEnrolledCourses().first(where: { $0.id == course.id })
        
        if let enrolledCourse {
            self.lastVideoTime = enrolledCourse.videoCurrentTime
        }
    }
    
    func setVideoDurationForCourse(duration: Double) {
        enrolledCoursesService.updateCourseVideoDuration(courseId: course.id, videoDuration: duration)
    }
    
    func setVideoCurrentTimeForCourse(currentTime: Double) {
        enrolledCoursesService.updateCourseVideoCurrentTime(courseId: course.id, currentTime: currentTime)
    }
    
    func setVideoCompletion() {
        enrolledCoursesService.updateCourseCompletion(courseId: course.id, isCompleted: true)
    }
}
