//
//  ServiceExecutor+Task.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/5/21.
//

import Foundation

extension ServiceExecutor {
    
    func  executeTask(urlRequest: URLRequest,
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
    
    func executeUploadTask(urlRequest: URLRequest,
                           fileURL: URL,
                     resultCompletion: @escaping TaskResultCompletion<T>) {
        task = serviceSession.session.uploadTask(with: urlRequest, fromFile: fileURL, completionHandler: { (data, response, error) in
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
        let (data, response) = try await serviceSession.session.upload(for: urlRequest, fromFile: fileURL, delegate: .none)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ServiceErrors.failureResponse }
        let model = try ServiceDataParser<T>().parse(data)
        return model
    }
    
    func executeUploadTaskInBackground(urlRequest: URLRequest,
                                       fileURL: URL) {
        let task = serviceSession.backgroundSession.uploadTask(with: urlRequest, fromFile: fileURL)
        task.resume()
    }
    
    func executeDownloadTaskInBackground(urlRequest: URLRequest) {
        let task = serviceSession.backgroundSession.downloadTask(with: urlRequest.url!)
        task.resume()
    }
    
    func executeResumeDownload(_ data: Data) {
        let task = serviceSession.backgroundSession.downloadTask(withResumeData: data)
        task.resume()
    }
    
}
