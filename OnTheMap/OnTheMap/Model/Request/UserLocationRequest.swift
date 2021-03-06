//
//  UserLocationRequest.swift
//  OnTheMap
//
//  Created by Sophia Lu on 7/30/21.
//

import Foundation


struct UserLocationRequest: Codable {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
