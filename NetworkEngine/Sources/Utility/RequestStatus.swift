//
//  RequestStatus.swift
//  NE iOS
//
//  Created by Kanwar Zorawar Singh Rana on 6/4/22.
//

import UIKit

public enum RequestStatus<T> {
    case loading
    case loaded(result: T)
    case error(error: Error)
}
