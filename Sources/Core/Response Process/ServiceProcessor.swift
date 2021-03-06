//
//  ServiceProcessor.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/5/21.
//

import Foundation

public struct ServiceResponse {
    let data: Data?
    let response: URLResponse?
    let error: Error?
}

struct ServiceStatusCode {
    static let success = 200...299
    static let redirect = 300...399
    static let clientError = 400...499
    static let serverError = 500...599
}

public class ServiceProcessor<T> {
    let serviceResponse: ServiceResponse
    
    @discardableResult
    init(_ serviceResponse: ServiceResponse) {
        self.serviceResponse = serviceResponse
    }
    
    func process(completion: TaskResultCompletion<T>) {
        completion(verifyError())
    }
    
    func process() -> Result<T, Error> {
        return verifyError()
    }
    
    func verifyError() -> Result<T, Error> {
        switch serviceResponse.error {
        case .none:
            return verifyResponse()
        case .some(let error):
            return .failure(error)
        }
    }
    
    func verifyResponse() -> Result<T,Error> {
        guard let response = serviceResponse.response as? HTTPURLResponse else { return .failure(ServiceErrors.failureResponse) }
        let statusCode = response.statusCode
        switch statusCode {
        case ServiceStatusCode.success:
            return verifyData()
        default:
            return .failure(ServiceErrors.noSuccess(serviceResponse))
        }
    }
    
    func verifyData() -> Result<T,Error> {
        switch serviceResponse.data {
        case .none:
            return .failure(ServiceErrors.noData)
        default:
            return ServiceDataParser<T>().parseModel(data: serviceResponse.data)
        }
    }
    
}
