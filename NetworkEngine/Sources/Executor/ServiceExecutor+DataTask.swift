//
//  ServiceExecutor+Task.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/5/21.
//

import Foundation

extension ServiceExecutor {
    
    func  executeDataTask(urlRequest: URLRequest,
                     resultCompletion: @escaping TaskResultCompletion<T>) {
        task = serviceSession.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            let response = ServiceResponse(data: data, response: response, error: error)
            ServiceProcessor<T>(response).process { (result) in
                DispatchQueue.main.async {
                    resultCompletion(result)
                }
            }
        })
        startTask()
    }
    
    func executeDataTask(urlRequest: URLRequest,
                      completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        task = serviceSession.session.dataTask(with: urlRequest, completionHandler: completionHandler)
        startTask()
    }
    
    @available(iOS 15.0, *)
    func executeDataTask(urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await serviceSession.session.data(for: urlRequest, delegate: .none)
        let responseModel = ServiceResponse(data: data, response: response, error: .none)
        let result = ServiceProcessor<T>(responseModel).process()
        switch result {
        case .success(let model):
            return model
        case .failure(let error):
            throw error
        }
    }
    
}
