//
//  File.swift
//  
//
//  Created by Kanwar Zorawar Singh Rana on 2/25/22.
//

import Foundation

extension ServiceExecutor {
    
    func executeDownloadTaskInBackground(urlRequest: URLRequest) {
        let task = serviceSession.backgroundSession.downloadTask(with: urlRequest.url!)
        task.resume()
    }
    
    func executeResumeDownload(_ data: Data) {
        let task = serviceSession.backgroundSession.downloadTask(withResumeData: data)
        task.resume()
    }
    
}
