//
//  StudentInformationResponse.swift
//  OnTheMap
//
//  Created by Sophia Lu on 7/26/21.
//

import Foundation

struct GetStudentInfoResponse: Codable {
    let results: [StudentInfo]
}

struct StudentInfo: Codable {
    let createdDate: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let city: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updateDate: String
    
    enum CodingKeys: String, CodingKey {
        case createdDate = "createdAt"
        case firstName = "firstName"
        case lastName = "lastName"
        case latitude = "latitude"
        case longitude = "longitude"
        case city = "mapString"
        case mediaURL = "mediaURL"
        case objectId = "objectId"
        case uniqueKey = "uniqueKey"
        case updateDate = "updatedAt"
    }
}
