//
//  ServiceTaskOperation.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/5/21.
//

import Foundation

class ServiceTaskOperation: Operation {
    let task: URLSessionTask
    
    init(withTask task: URLSessionTask) {
        self.task = task
        task.resume()
        super.init()
    }
}
