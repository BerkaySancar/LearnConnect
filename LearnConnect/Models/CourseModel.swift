//
//  CourseModel.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import Foundation

struct Course: Codable, Hashable, Identifiable {
    let createdAt, name, description, instructor: String
    let video: String
    let thumbnail: String
    let category: String
    let id: String
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case createdAt, name, description, instructor, video, thumbnail, category, id
        
    }
    
    static var example: Course = .init(
        createdAt: "2024-11-24T01:02:14.794Z",
        name: "Mastering Minimalist Design: The Art of Less",
        description: "Discover the principles of minimalist design and learn how to create impactful visuals with simplicity. Perfect for aspiring designers and enthusiasts.",
        instructor: "Charlotte Nienow",
        video: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_20mb.mp4",
        thumbnail: "https://dac.digital/wp-content/uploads/2023/07/1ud5eeycUbeH1kp1ln_gkJg-1200x680.jpe",
        category: "Software",
        id: "1",
        isFavorite: false
    )
    
    func toCopy(isFavorite: Bool) -> Course {
        return Course(
            createdAt: self.createdAt,
            name: self.name,
            description: self.description,
            instructor: self.instructor,
            video: self.video,
            thumbnail: self.thumbnail,
            category: self.category,
            id: self.id,
            isFavorite: isFavorite
        )
    }
}
