//
//  RequestError.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 1/29/22.
//

import Foundation

public enum RequestError: NetworkEngineError {
    case invalidURL
    case invalidComponents
    
    public var errorModel: ErrorDescription {
        switch self {
        case .invalidURL:
            return ErrorDescription(code: .none, string: "invalidURL", message: "Please check the URL")
        case .invalidComponents:
            return ErrorDescription(code: .none, string: "invalidComponents", message: "Please check the request parameters")
        }
    }
}

public enum ServiceErrors: NetworkEngineError {
    case noResponse
    case failureResponse
    case noData
    case parseError
    case decodable
    case jsonParse
    case jsonSerialization
    case noType
    case noSuccess(ServiceResponse)
    
    public var errorModel: ErrorDescription {
        switch self {
        case .noResponse:
            return ErrorDescription(code: .none, string: "noResponse", message: "No Response")
        case .failureResponse:
            return ErrorDescription(code: .none, string: "failureResponse", message: "Response failed")
        case .noData:
            return ErrorDescription(code: .none, string: "noData", message: "No Data in response")
        case .parseError:
            return ErrorDescription(code: .none, string: "parseError", message: "Could Not parse data")
        case .decodable:
            return ErrorDescription(code: .none, string: "decodable", message: "Could Not decode properly")
        case .jsonParse:
            return ErrorDescription(code: .none, string: "jsonParse", message: "Could Not parse json  decodable properly")
        case .noSuccess(let serviceResponse):
            guard let status = (serviceResponse.response as? HTTPURLResponse)?.statusCode else {
                return ErrorDescription(code: .none, string: "noSuccess", message: "Response is not success")
            }
            return ErrorDescription(code: status.description, string: "noSuccess", message: "Response is not success")
        case .noType:
            return ErrorDescription(code: .none, string: "noType", message: "Generic Type Not Defined")
        case .jsonSerialization:
            return ErrorDescription(code: .none, string: "jsonSerialization", message: "Could not serialize json object")
        }
    }
}
