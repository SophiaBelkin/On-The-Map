//
//  GetStudentLocationResponse.swift
//  OnTheMap
//
//  Created by Sophia Lu on 7/27/21.
//

import Foundation

class PostStudentInfoResponse: Codable {
    var uniqueKey: UUID = UUID()
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
