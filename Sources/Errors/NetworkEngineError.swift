//
//  NetworkEngineError.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 1/31/22.
//

public protocol NetworkEngineError: Error {
    var errorModel: ErrorDescription { get }
}

public extension NetworkEngineError {
    var localizedDescription: String {
        var description = "** Error Description **\n"
        if let code = errorModel.code {
            description.append(contentsOf: "Error Code: \(code) \n")
        }
        if let string = errorModel.string {
            description.append(contentsOf: "Error String: \(string) \n")
        }
        if let message = errorModel.message {
            description.append(contentsOf: "Error Message: \(message) \n")
        }
        return description
    }
}

public extension Error {
    var description: String {
        return (self as? NetworkEngineError)?.localizedDescription ?? self.localizedDescription
    }
}

public struct ErrorDescription {
    public let code: String?
    public let string: String?
    public let message: String?
}
