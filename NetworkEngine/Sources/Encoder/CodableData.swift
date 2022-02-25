//
//  StringDictionaryEncoder.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/13/21.
//

import Foundation

public typealias JsonDictionary = [String: Any]
public typealias StringDictionary = [String: String]

public protocol NetworkEngineEncoder: Encodable {
    var jsonDictionary: JsonDictionary? { get }
    var stringDictionary: StringDictionary? { get }
    var queryItems: [URLQueryItem]? { get }
    var data: Data? { get }
}

public extension NetworkEngineEncoder {
    var jsonDictionary: JsonDictionary? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: jsonData,
                                                                        options: .allowFragments) as? JsonDictionary else {
                    return .none
                }
                return dictionary
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        return .none
    }
    
    var stringDictionary: StringDictionary? {
        guard let dictionary = jsonDictionary else {
            return .none
        }
        
        var stringDictionary = StringDictionary()
        for (key, value) in dictionary {
            if let value = value as? String {
                stringDictionary[key] = value
            }
        }
        return stringDictionary
    }
    
    var queryItems: [URLQueryItem]? {
        guard let dictionary = jsonDictionary else {
            return .none
        }
        
        var urlQueryArray = [URLQueryItem]()
        for (key, value) in dictionary {
            if let value = value as? String {
                let queryItem = URLQueryItem(name: key, value: value)
                urlQueryArray.append(queryItem)
            }
        }
        return urlQueryArray
    }
    
    var data: Data? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return jsonData
        } catch {
            print(error)
        }
        return .none
    }
}
