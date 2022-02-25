//
//  ServiceDataParser.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/5/21.
//

import Foundation

public class ServiceDataParser<T> {
    
    func parseModel(data: Data?) -> Result<T, Error> {
        guard let data = data else {
            return .failure(ServiceErrors.noData)
        }
        
        if T.self is Data.Type {
            guard let data = data as? T else {
                return .failure(ServiceErrors.noData)
            }
            return .success(data)
        }else if let decodableType = T.self as? Decodable.Type {
            do {
                let model = try decodableType.init(decodableData: data)
                guard let decodableModel = model as? T else {
                    return .failure(ServiceErrors.decodable)
                }
                return .success(decodableModel)
            } catch  {
                return .failure(error)
            }
        } else if T.self is String.Type {
            guard let string = String(data: data, encoding: .utf8) as?T else {
                return .failure(ServiceErrors.noData)
            }
            return .success(string)
        }
        return .failure(ServiceErrors.noType)
    }
}
