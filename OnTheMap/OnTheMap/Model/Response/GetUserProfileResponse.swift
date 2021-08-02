//
//  getUserProfileResponse.swift
//  OnTheMap
//
//  Created by Sophia Lu on 8/1/21.
//

import Foundation

struct GetUserProfileResponse: Codable {
    let user: UserProfile
}

struct UserProfile: Codable {
    let firstName: String = "John"
    let lastName: String = "D"
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
