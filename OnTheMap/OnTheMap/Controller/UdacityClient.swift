//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Sophia Lu on 7/26/21.
//

import Foundation

class UdacityClient {
    
    struct Auth {
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getSessionID
        case userLocation
        case webAuth
        
        var stringValue: String {
            switch self {
            case .userLocation:
                return Endpoints.base + "/StudentLocation"
       
            case .getSessionID:
                return Endpoints.base +  "/session"
            case .webAuth:
                return ""
            }
        }
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
    }
    
    class func taskForGETRequest() {
        
    }
    
    class func taskForPOSTRequest() {
        
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let login = LoginRequest(username: username, password: password)
        
        var request = URLRequest(url: Endpoints.getSessionID.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(login.username)\", \"password\": \"\(login.password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(false, error)
                return
            }
            print(String(data: data, encoding: .utf8)!)
            let decoder = JSONDecoder()
            let range = (5..<data.count)
            let newData = data.subdata(in: range)
            print(String(data: newData, encoding: .utf8)!)
            do {
                _ = try decoder.decode(LoginResponse.self, from: newData)
                
                completion(true, nil)
            } catch {
                completion(false, error)
            }
        }
        task.resume()
    }
    
}
