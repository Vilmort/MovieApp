//
//  KPMovieRequest.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public struct KPMovieRequest: KPNetworkRequest {
    public typealias Response = KPMovieEntity
    
    private let id: Int
    
    public init(id: Int) {
        self.id = id
    }
    
    public var url: String {
        "movie/\(id)"
    }
    
    public var method: KPHTTPMethod {
        .GET
    }
    
    public var parameters: [String : String] {
        [:]
    }
}
