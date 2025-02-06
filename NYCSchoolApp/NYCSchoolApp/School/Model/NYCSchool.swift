//
//  NYCSchool.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation

struct NYCSchool: Codable {
    let id = UUID().uuidString
    let schoolName: String?
    let city: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case city = "city"
        case description = "overview_paragraph"
    }
}
