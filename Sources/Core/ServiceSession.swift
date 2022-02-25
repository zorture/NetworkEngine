//
//  ServiceSession.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/5/21.
//

import Foundation

open class ServiceSession {
    public static let shared = ServiceSession()
    private let sessionQueue = OperationQueue()
    let sessionDelegate = ServiceSessionDelegate()
    
    lazy var backgroundSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        config.isDiscretionary = false
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: sessionDelegate, delegateQueue: sessionQueue)
    }()
    
    lazy var systemSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = NetworkEngine.concurrentRequestCount
        return URLSession(configuration: config, delegate: nil, delegateQueue: sessionQueue)
    }()
    
    lazy var mockSession: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockDataURL.self]
        return URLSession(configuration: config, delegate: nil, delegateQueue: sessionQueue)
    }()
    
    var session: URLSession {
        switch NetworkEngine.session {
        case .system:
            return systemSession
        case .background:
            return backgroundSession
        case .mock:
            return mockSession
        }
    }
    
    private init() {
        sessionQueue.maxConcurrentOperationCount = NetworkEngine.concurrentRequestCount
    }
}

extension ServiceSession {
    func addTask(withOperation taskOperation: ServiceTaskOperation) {
        sessionQueue.addOperation(taskOperation)
    }
}
