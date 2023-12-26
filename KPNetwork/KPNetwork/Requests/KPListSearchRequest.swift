//
//  KPListSearchRequest.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public struct KPListSearchRequest: KPNetworkRequest {
    
    public typealias Response = KPListSearchEntity
    
    public init() {}
    
    public var url: String {
        "list"
    }
    
    public var method: KPHTTPMethod {
        .GET
    }
    
    public var parameters: [String : String] {
        ["limit": "250"]
    }
}
