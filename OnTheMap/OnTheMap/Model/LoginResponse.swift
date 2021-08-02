//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Sophia Lu on 7/26/21.
//

import Foundation

struct LoginResponse: Codable {
    let account: Account
    let session: Session
}


struct Account: Codable {
    let isRegistered: Bool
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case isRegistered = "registered"
        case key
    }
}

struct Session: Codable {
    let id: String
    let expirationTime: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case expirationTime = "expiration"
    }
}
