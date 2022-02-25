//
//  MockDataURL.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 1/28/22.
//

import Foundation

class MockDataURL: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        
        guard let url = request.url else {
            client?.urlProtocol(self, didFailWithError: MockEngineError.invalidURL)
            return
        }
        
        guard let mockResponse = MockEngine.mockMap[MockURL(url)],
              let data = mockResponse.data else {
            client?.urlProtocol(self, didFailWithError: MockEngineError.noMockData)
            return
        }
        
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: .none, headerFields: .none) else {
            client?.urlProtocol(self, didFailWithError: MockEngineError.responseFail)
            return
        }
        
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        self.client?.urlProtocolDidFinishLoading(self)
    }

    // this method is required but doesn't need to do anything
    override func stopLoading() { }
}
