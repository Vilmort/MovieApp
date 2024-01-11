//
//  KPPossibleValuesRequest.swift
//  KPNetwork
//
//  Created by Victor on 11.01.2024.
//

import Foundation

public struct KPPossibleValuesRequest: KPNetworkRequest {
    public typealias Response = [KPPossibleValue]
    
    public enum Value: String {
        case genres = "genres.name"
    }
    
    private let value: Value
    
    public init(value: Value) {
        self.value = value
    }
    
    public var url: String {
        "https://api.kinopoisk.dev/v1/movie/possible-values-by-field"
    }
    
    public var method: KPHTTPMethod {
        .GET
    }
    
    public var parameters: [String : Any] {
        ["field" : value.rawValue]
    }
}
