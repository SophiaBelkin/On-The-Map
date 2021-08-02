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
        static var key = ""
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getSessionID
        case getUserLocations
        case postUserLocation
        case changeUserLocation
        case getUserProfile
        case webAuth
        
        var stringValue: String {
            switch self {
            case .getUserLocations:
                return Endpoints.base + "/StudentLocation?limit=100"
            case .postUserLocation:
                return Endpoints.base + "/StudentLocation"
            case .changeUserLocation:
                return Endpoints.base + "/StudentLocation/\(Auth.objectId)"
            case .getUserProfile:
                return Endpoints.base + "/users/\(Auth.sessionId)"
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
    
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let requestBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        
        HTTPRequests.taskForPOSTRequest(url: Endpoints.getSessionID.url, type: "parse", body: requestBody, response: LoginResponse.self) { response, error in
            if let response = response {
                Auth.sessionId = response.session.id
                Auth.key = response.account.key
                
                self.getUserProfile() {_, _ in
                }
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func getUserProfile(completion: @escaping (Bool, Error?) -> Void) {
        HTTPRequests.taskForGETRequest(url: Endpoints.getUserProfile.url, response: GetUserProfileResponse.self) { response, error in
            if let response = response {
                Auth.firstName = response.user.firstName
                Auth.lastName = response.user.lastName
                completion(true, nil)
            } else {
                Auth.firstName = "John"
                Auth.lastName = "D"
                completion(false, error)
            }
        }
    }
    
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.getSessionID.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(false, error)
                return
            }

            let decoder = JSONDecoder()
            let range = (5..<data.count)
            let newData = data.subdata(in: range)
            do {
                _ = try decoder.decode(LoginResponse.self, from: newData)
                Auth.sessionId = ""
                completion(true, nil)
            } catch {
                completion(false, error)
            }
        }
        task.resume()
    }
    
    
    class func getStudentsInfo(completion: @escaping ([StudentInfo], Error?) -> Void) {
        HTTPRequests.taskForGETRequest(url: Endpoints.getUserLocations.url, response: GetStudentInfoResponse.self) { response, error in
            if let response = response {
                let studentInfo = response.results.sorted{ $0.updateDate > $1.updateDate}
                completion(studentInfo, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func postStudentInfo(mapString: String, mediaURL: String, latitude: Double, longitude: Double, completion: @escaping (Bool, Error?) -> Void) {
        let studentInfo = UserLocationRequest(uniqueKey: UUID().uuidString, firstName: Auth.firstName, lastName: Auth.lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude)
        var requestBody = ""
        do {
            let data = try JSONEncoder().encode(studentInfo)
            requestBody = String(data: data, encoding: .utf8)!
            print("\(#function) \(requestBody)")
        } catch {
            print(error)
        }
        
        HTTPRequests.taskForPOSTRequest(url: Endpoints.postUserLocation.url, body: requestBody, response: PostStudentInfoResponse.self) { response, error in
            if let response =  response {
                Auth.objectId = response.objectId
                completion(true, error)
            } else {
                completion(false, error)
            }
        }
    }
}
