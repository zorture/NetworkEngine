//
//  ServiceExecutor+UploadTask.swift
//  
//
//  Created by Kanwar Zorawar Singh Rana on 2/25/22.
//

import Foundation

extension ServiceExecutor {

    func executeUploadTask(urlRequest: URLRequest,
                           fileURL: URL,
                     resultCompletion: @escaping TaskResultCompletion<T>) {
        task = serviceSession.session.uploadTask(with: urlRequest,
                                                 fromFile: fileURL,
                                                 completionHandler: { (data, response, error) in
            let response = ServiceResponse(data: data, response: response, error: error)
            ServiceProcessor<T>(response).process { (result) in
                DispatchQueue.main.async {
                    resultCompletion(result)
                }
            }
        })
        startTask()
    }
    
    @available(iOS 15.0, *)
    func executeUploadTask(urlRequest: URLRequest,
                           fileURL: URL) async throws -> T {
        let (data, response) = try await serviceSession.session.upload(for: urlRequest,
                                                                       fromFile: fileURL,
                                                                       delegate: ServiceSession.shared.sessionDelegate)
        let responseModel = ServiceResponse(data: data,
                                            response: response,
                                            error: .none)
        let result = ServiceProcessor<T>(responseModel).process()
        switch result {
        case .success(let model):
            return model
        case .failure(let error):
            throw error
        }
    }
    
    func executeUploadTaskInBackground(urlRequest: URLRequest,
                                       fileURL: URL) {
        task = serviceSession.backgroundSession.uploadTask(with: urlRequest,
                                                           fromFile: fileURL)
        startTask()
    }

}
