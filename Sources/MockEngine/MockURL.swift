//
//  MockURL.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 1/28/22.
//

import Foundation

public struct MockURL: Hashable {
    public let url: URL
    public init(_ url: URL) {
        self.url = url
    }
    
    public static func == (lhs: MockURL, rhs: MockURL) -> Bool {
        guard let lQuery = lhs.url.query,
              let rQuery = rhs.url.query else {
            return lhs.url.absoluteURL == rhs.url.absoluteURL
        }
        
        let lQueryArray = lQuery.components(separatedBy: "&")
        let rQueryArray = rQuery.components(separatedBy: "&")
        let lQuerySet = Set(lQueryArray)
        let rQuerySet = Set(rQueryArray)
        return lQuerySet == rQuerySet
    }
    
    public func hash(into hasher: inout Hasher) {
        guard let query = url.query else {
            hasher.combine(url)
            return
        }
        let queryArray = query.components(separatedBy: "&")
        let querySet = Set(queryArray)
        hasher.combine(querySet)
        hasher.combine(url.path)
    }
}
