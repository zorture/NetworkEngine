//
//  MockResponse.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 1/28/22.
//

import Foundation

public struct MockResponse {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    public init(_ data: Data, response: URLResponse? = .none, error: Error? = .none) {
        self.data = data
        self.response = response
        self.error = error
    }
}
