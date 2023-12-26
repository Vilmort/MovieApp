//
//  KPMovieSearchRequest.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public struct KPMovieSearchRequest: KPNetworkRequest {
    public typealias Response = KPMovieSearchEntity
    
    public init(
        page: Int? = nil,
        limit: Int? = nil,
        id: [String]? = nil,
        type: KPMovieType? = nil,
        lists: [String]? = nil
    ) {
        if let page {
            parameters["page"] = "\(page)"
        }
        if let limit {
            parameters["limit"] = "\(limit)"
        }
        parameters["id"] = id?.joined(separator: ",")
        parameters["type"] = type?.rawValue
        parameters["lists"] = lists?.joined(separator: ",")
    }
    
    public var url: String {
        "movie"
    }
    
    public var method: KPHTTPMethod {
        .GET
    }
    
    public var parameters: [String : String] = [:]
}
