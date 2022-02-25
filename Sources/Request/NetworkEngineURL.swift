//
//  NetworkEngineURL.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/13/21.
//

import Foundation

public enum URLScheme: String {
    case http
    case https
}

public protocol NetworkEngineURL {
    var host: String { get }
    var scheme: URLScheme { get }
    var port: Int? { get }
    var path: String? { get }
}
