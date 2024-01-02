//
//  KPNetworkRequest.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public enum KPHTTPMethod: String {
    case GET, POST
}

public protocol KPNetworkRequest {
    associatedtype Response: Decodable
    
    var url: String { get }
    var method: KPHTTPMethod { get }
    var parameters: [String: String] { get }
}
