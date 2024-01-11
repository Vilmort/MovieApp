//
//  KPMovieSearchTitleRequest.swift
//  KPNetwork
//
//  Created by Victor on 11.01.2024.
//

import Foundation

public struct KPMovieSearchTitleRequest: KPNetworkRequest {
    public typealias Response = KPMovieSearchEntity
    
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
        "movie/search"
    }
    
    public var method: KPHTTPMethod {
        .GET
    }
    
    public var parameters: [String : Any] = [:]
}
