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
        case getUserLocations
        case postUserLocation
        case changeUserLocation(String)
        case userLocationById(String)
        case webAuth
        
        var stringValue: String {
            switch self {
            case .getUserLocations:
                return Endpoints.base + "/StudentLocation?limit=100"
            case .postUserLocation:
                return Endpoints.base + "/StudentLocation"
            case .changeUserLocation(let userId):
                return Endpoints.base + "/StudentLocation/\(userId)"
            case .userLocationById(let userId):
                return Endpoints.base + "/users/\(userId)"
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
                completion(true, nil)
            } catch {
                completion(false, error)
            }
        }
        task.resume()
    }
    
    
    class func getStudentsInfo(completion: @escaping ([StudentInfo], Error?) -> Void) {
        let request = URLRequest(url: Endpoints.getUserLocations.url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion([], error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let studentData = try decoder.decode(GetStudentInfoResponse.self, from: data)
                completion(studentData.results, nil)
            } catch {
                completion([], error)
            }
        }
        
        task.resume()
    }
    
    class func postStudentInfo(completion: @escaping (Bool, Error?) -> Void) {
        let studentInfo = UserLocationRequest(mapString: "Los Angeles", mediaURL: "https://www.google.com", latitude: 37.386052, longitude: -122.083851)
        var request = URLRequest(url: Endpoints.postUserLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(studentInfo)
        } catch {
            print(error)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
}
