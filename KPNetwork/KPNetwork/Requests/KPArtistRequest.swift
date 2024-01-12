//
//  KPArtistRequest.swift
//  KPNetwork
//
//  Created by Victor on 12.01.2024.
//

import Foundation

public struct KPArtistRequest: KPNetworkRequest {
    
    public typealias Response = KPArtistEntity
    
    let id: Int
    
    public init(id: Int) {
        self.id = id
    }
    
    public var url: String {
        "person/\(id)"
    }
    
    public var method: KPHTTPMethod {
        .GET
    }
    
    public var parameters: [String : Any] = [:]
    
}
