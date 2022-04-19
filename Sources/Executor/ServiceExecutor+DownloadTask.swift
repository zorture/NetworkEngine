//
//  ServiceExecutor+DownloadTask.swift
//  
//
//  Created by Kanwar Zorawar Singh Rana on 2/25/22.
//

import Foundation

extension ServiceExecutor {
    
    func executeDownloadTaskInBackground(urlRequest: URLRequest) {
        task = serviceSession.backgroundSession.downloadTask(with: urlRequest.url!)
        startTask()
    }
    
    func executeResumeDownload(_ data: Data) {
        task = serviceSession.backgroundSession.downloadTask(withResumeData: data)
        startTask()
    }
    
}
