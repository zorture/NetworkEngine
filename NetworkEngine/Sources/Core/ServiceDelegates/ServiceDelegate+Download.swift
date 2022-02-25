//
//  ServiceDelegate+Download.swift
//  
//
//  Created by Kanwar Zorawar Singh Rana on 2/26/22.
//

import Foundation

extension ServiceDelegate: URLSessionDownloadDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {}
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else {
            // Handle success case.
            return
        }
        let userInfo = (error as NSError).userInfo
        if let resumeData = userInfo[NSURLSessionDownloadTaskResumeData] as? Data {
            //self.resumeData = resumeData
            NetworkEngine.executeResumeDownload(resumeData)
        }
        print("We're done here")
    }
    
    // Download Delegate
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        print(location)
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
            // your destination file url
        let destinationUrl = documentsUrl.appendingPathComponent(String(downloadTask.response!.suggestedFilename!))
        print(destinationUrl as Any)

        if FileManager.default.fileExists(atPath: destinationUrl!.path) {
            print("The file already exists at path")
        } else {
            do {
            let data = try Data(contentsOf: (downloadTask.response?.url)!)
                do {
                    try data.write(to: destinationUrl!, options: .atomic)
                } catch {
                    print(error)
                }
            } catch {
                print(error)
            }
            
        }
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        print("\(bytesWritten): \(totalBytesWritten): \(totalBytesExpectedToWrite)")
    }

}
