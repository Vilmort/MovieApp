//
//  KPImagesRequest.swift
//  KPNetwork
//
//  Created by Victor on 02.01.2024.
//

import Foundation

public struct KPImagesRequest: KPNetworkRequest {
    public typealias Response = KPImagesEntity
    
    public enum ImageType: String {
        case frame, wallpaper, cover, shooting, still
    }
    
    public init(id: Int, type: ImageType? = .frame, limit: Int) {
        parameters["movieId"] = String(id)
        parameters["type"] = type?.rawValue
        parameters["limit"] = String(limit)
    }
    
    public var url: String {
        "image"
    }
    
    public var method: KPHTTPMethod {
        .GET
    }
    
    public var parameters = [String: String]()
}
