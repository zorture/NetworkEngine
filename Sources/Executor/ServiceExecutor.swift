//
//  ServiceExecutor.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/5/21.
//

import Foundation

class ServiceExecutor<T> {
    let serviceSession = ServiceSession.shared
    var task: URLSessionTask!
    
    func startTask() {
        let taskOperation = ServiceTaskOperation(withTask: task)
        serviceSession.addTask(withOperation: taskOperation)
    }
}
