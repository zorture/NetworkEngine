//
//  MockEngineError.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 1/29/22.
//

public enum MockEngineError: NetworkEngineError {
    case invalidURL
    case noMockData
    case responseFail
    case mockFileNotFound
    case invalidMockFileURL
    case noJsonString
    
    public var errorModel: ErrorDescription {
        switch self {
        case .invalidURL:
            return ErrorDescription(code: .none, string: "invalidURL", message: "Please check the URL")
        case .noMockData:
            return ErrorDescription(code: .none, string: "noMockData", message: "Please check the mock data")
        case .responseFail:
            return ErrorDescription(code: .none, string: "responseFail", message: "The Response mapping failed")
        case .mockFileNotFound:
            return ErrorDescription(code: .none, string: "mockFileNotFound", message: "Please check the Mock File name")
        case .invalidMockFileURL:
            return ErrorDescription(code: .none, string: "invalidMockFileURL", message: "Please check the Mock File Bundle")
        case .noJsonString:
            return ErrorDescription(code: .none, string: "noJsonString", message: "Please check the json in the mock file")
        }
    }
    
}
