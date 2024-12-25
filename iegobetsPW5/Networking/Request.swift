//
//  Request.swift
//  iegobetsPW5
//
//  Created by Ivan on 25.12.2024.
//

import Foundation

struct Request {
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    var endpoint: Endpoint
    var method: Method
    var parameters: [String: String]?
    var timeInterval: TimeInterval
    let body: Data?
    
    init(
        endpoint: Endpoint,
        method: Method = Method.get,
        parametrs: [String : String]? = nil,
        body: Data? = nil,
        timeInterval: TimeInterval = 60
    ) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parametrs
        self.timeInterval = timeInterval
        self.body = body
        
        if var endpointParameters = endpoint.parametrs {
            for (key, value) in parametrs ?? [:] {
                endpointParameters[key] = value
            }
            
            self.parameters = endpointParameters
        }
    }
}
