//
//  MockEngine.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 1/28/22.
//

import Foundation

public class MockEngine {
    static var mockMap = [MockURL:MockResponse]()
    
    public class func addMock(_ response: MockResponse, forURL url: MockURL) {
        MockEngine.mockMap[url] = response
    }
    
    public class func clearMock() {
        MockEngine.mockMap.removeAll()
    }
    
    public class func loadMockData(fileName name: String, bundle: Bundle) throws -> Data {
        guard let pathString = bundle.path(forResource: name, ofType: "json") else {
            throw MockEngineError.mockFileNotFound
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            throw MockEngineError.noJsonString
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw MockEngineError.noMockData
        }
        return jsonData
    }
    
}

