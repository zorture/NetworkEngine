//
//  NetworkEngine.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/5/21.
//

import Foundation

public enum SessionType {
    case system
    case background
    case mock
}

public class NetworkEngine {
    
    public static var concurrentRequestCount = 10
    static var session: SessionType = .system
    
    public class func start(_ type: SessionType) {
        NetworkEngine.session = type
    }
}

public typealias TaskResultCompletion<T> = (Result<T, Error>) -> Void

public extension NetworkEngine {
    
    class func executeRequest(urlRequest: URLRequest,
                              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        ServiceExecutor<Data>().executeDataTask(urlRequest: urlRequest, completionHandler: completionHandler)
    }
    
    class func executeRequest(urlRequest: NetworkEngineRequest,
                              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        do {
            let request =  try urlRequest.request()
            ServiceExecutor<Data>().executeDataTask(urlRequest: request, completionHandler: completionHandler)
        } catch (let error) {
            completionHandler(.none, .none, error)
        }
    }
    
    class func executeRequest<T>(urlRequest: URLRequest,
                                 type: T.Type,
                                 resultCompletion: @escaping TaskResultCompletion<T>) {
        ServiceExecutor<T>().executeDataTask(urlRequest: urlRequest, resultCompletion: resultCompletion)
    }
    
    class func executeRequest<T>(urlRequest: NetworkEngineRequest,
                                 type: T.Type,
                                 resultCompletion: @escaping TaskResultCompletion<T>) {
        do {
            let request =  try urlRequest.request()
            ServiceExecutor<T>().executeDataTask(urlRequest: request, resultCompletion: resultCompletion)
        } catch (let error) {
            resultCompletion(.failure(error))
        }
    }
    
    @available(iOS 15.0, *)
    class func executeRequest<T>(urlRequest: URLRequest,
                                 type: T.Type) async throws -> T {
        return try await ServiceExecutor<T>().executeDataTask(urlRequest: urlRequest)
    }
    
    @available(iOS 15.0, *)
    class func executeRequest<T>(urlRequest: NetworkEngineRequest,
                                 type: T.Type) async throws -> T {
        do {
            let request =  try urlRequest.request()
            return try await ServiceExecutor<T>().executeDataTask(urlRequest: request)
        } catch (let error) {
            throw error
        }
    }
    
    class func executeUploadRequest<T>(urlRequest: URLRequest,
                                       type: T.Type,
                                       fileURL: URL,
                                       resultCompletion: @escaping TaskResultCompletion<T>) {
        ServiceExecutor<T>().executeUploadTask(urlRequest: urlRequest, fileURL: fileURL, resultCompletion: resultCompletion)
    }
    
    @available(iOS 15.0, *)
    class func executeUploadRequest<T>(urlRequest: URLRequest,
                                       type: T.Type,
                                       fileURL: URL) async throws -> T {
        return try await ServiceExecutor<T>().executeUploadTask(urlRequest: urlRequest, fileURL: fileURL)
    }
    
    class func executeUploadRequestInBackground<T>(urlRequest: URLRequest,
                                                   type: T.Type,
                                                   fileURL: URL) {
        ServiceExecutor<T>().executeUploadTaskInBackground(urlRequest: urlRequest, fileURL: fileURL)
    }
    
    class func executeDownloadRequestInBackground<T>(urlRequest: URLRequest,
                                                     type: T.Type) {
        ServiceExecutor<T>().executeDownloadTaskInBackground(urlRequest: urlRequest)
    }
    
    class func executeResumeDownload(_ data: Data) {
        ServiceExecutor<Data>().executeResumeDownload(data)
    }
}
