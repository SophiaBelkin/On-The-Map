//
//  HTTPRequests.swift
//  OnTheMap
//
//  Created by Sophia Lu on 8/1/21.
//

import Foundation

class HTTPRequests {
    
    class func taskForGETRequest<ResponseType: Decodable> (url: URL, response: ResponseType.Type, completion:  @escaping  (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }

            do {
                let data = try JSONDecoder().decode(ResponseType.self, from: data)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    class func taskForPOSTRequest<ResponseType: Decodable> (url: URL, httpMethod: String = "POST", type: String = "", body: String, response: ResponseType.Type, completion: @escaping  (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod == "POST" ? "POST" : "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            var newData = data
            if type == "parse" {
                let range = (5..<data.count)
                newData = data.subdata(in: range)
            }
                
            do {
                let responseObject = try  JSONDecoder().decode(ResponseType.self, from: newData)
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
