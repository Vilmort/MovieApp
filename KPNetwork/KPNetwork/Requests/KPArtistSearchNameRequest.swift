//
//  KPArtistSearchNameRequest.swift
//  KPNetwork
//
//  Created by Victor on 12.01.2024.
//

import Foundation

public struct KPArtistSearchNameRequest: KPNetworkRequest {
    public typealias Response = KPArtistSearchEntity
    
    public init(
        page: Int? = nil,
        limit: Int? = nil,
        query: String
    ) {
        if let page {
            parameters["page"] = "\(page)"
        }
        if let limit {
            parameters["limit"] = "\(limit)"
        }
        parameters["query"] = query
    }
    
    public var url: String {
        "person/search"
    }
    
    public var method: KPHTTPMethod {
        .GET
    }
    
    public var parameters: [String : Any] = [:]
}

