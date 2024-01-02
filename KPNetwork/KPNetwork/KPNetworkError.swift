//
//  KPNetworkError.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public enum KPNetworkError: Error {
    case invalidToken
    case invalidDecoding
    case invalidURL
    case failedRequest
    case noMoreFreeRequests
    case networkError(KPNetworkErrorEntity?, URLError?)
}

public struct KPNetworkErrorEntity: Decodable {
    let statusCode: Int
    let message: String?
    let error: String?
}
