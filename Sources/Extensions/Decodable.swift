//
//  Decodable.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 4/5/21.
//

import Foundation

extension Decodable {
    init(decodableData: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: decodableData)
    }
}
