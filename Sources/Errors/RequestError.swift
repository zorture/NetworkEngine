//
//  RequestError.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 1/29/22.
//

import Foundation

enum RequestError: NetworkEngineError {
    case invalidURL
    case invalidComponents
    
    var errorModel: ErrorDescription {
        switch self {
        case .invalidURL:
            return ErrorDescription(code: .none, string: "invalidURL", message: "Please check the URL")
        case .invalidComponents:
            return ErrorDescription(code: .none, string: "invalidComponents", message: "Please check the request parameters")
        }
    }
}

enum ServiceErrors: NetworkEngineError {
    case transportError
    case noResponse
    case failureResponse
    case noData
    case parseError
    case decodable
    case jsonParse
    case notSuccess(ServiceResponse)
    
    var errorModel: ErrorDescription {
        switch self {
        case .transportError:
            return ErrorDescription(code: .none, string: "transportError", message: "Please check the Connection or TSL")
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
        case .notSuccess(let serviceResponse):
            guard let status = (serviceResponse.response as? HTTPURLResponse)?.statusCode else {
                return ErrorDescription(code: .none, string: "notSuccess", message: "Response is not success")
            }
            return ErrorDescription(code: status.description, string: "notSuccess", message: "Response is not success")
        }
    }
}
