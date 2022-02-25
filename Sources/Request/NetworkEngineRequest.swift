//
//  NetworkEngineRequest.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/13/21.
//

import Foundation

public enum RequestMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public protocol NetworkEngineRequest {
    var query: NetworkEngineEncoder? { get }
    var jsonData: NetworkEngineEncoder? { get }
    var body: Data? { get }
    var headers: StringDictionary? { get }
    var method: RequestMethod { get }
    var baseURL: URL? { get }
    var path: String? { get }
    func request() throws -> URLRequest
}

public extension NetworkEngineRequest {    
    func request() throws -> URLRequest {
        
        guard let baseURL = baseURL else {
            throw RequestError.invalidURL
        }
        
        var component = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        if let path = path {
            component?.path = path
        }
        if let query = query?.queryItems {
            component?.queryItems = query
        }
        
        guard let url = component?.url else {
            throw RequestError.invalidRequest
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if jsonData != nil {
            request.httpBody = jsonData?.data
        } else {
            request.httpBody = body
        }
        
        headers?.forEach({ (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        })
        
        return request
    }
}
