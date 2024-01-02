//
//  KPNetworkClient.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public protocol KPNetworkClient {
    func sendRequest<Request>(request: Request) async -> Result<Request.Response, KPNetworkError> where Request: KPNetworkRequest
}

public actor DefaultKPNetworkClient: KPNetworkClient {
    
    private let baseURL: String
    private var tokens =  [String]()
    private var currentToken: String?
    
    public init(baseURL: String, tokens: [String] = [String]()) {
        self.baseURL = baseURL
        self.tokens = tokens
        self.currentToken = tokens.first
    }
    
    public func sendRequest<Request>(request: Request) async -> Result<Request.Response, KPNetworkError> where Request: KPNetworkRequest {
        guard let currentToken else {
            return .failure(.invalidToken)
        }
        guard var urlComponents = URLComponents(string: baseURL + request.url) else {
            return .failure(.invalidURL)
        }
        urlComponents.queryItems = request.parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue(currentToken, forHTTPHeaderField: "X-API-KEY")
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            let decoder = JSONDecoder()
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidDecoding)
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                guard let decoded = try? decoder.decode(Request.Response.self, from: data) else {
                    return .failure(.invalidDecoding)
                }
                return .success(decoded)
            case 401:
                do {
                    try await setNextToken()
                    return await sendRequest(request: request)
                } catch {
                    return .failure(error as! KPNetworkError)
                }
            default:
                guard let decoded = try? decoder.decode(KPNetworkErrorEntity.self, from: data) else {
                    return .failure(.invalidDecoding)
                }
                return .failure(.networkError(decoded, nil))
            }
        } catch {
            return .failure(.networkError(nil, error as? URLError))
        }
    }
    
    private func setNextToken() async throws {
        tokens.removeFirst()
        currentToken = tokens.first
        if currentToken == nil {
            throw KPNetworkError.noMoreFreeRequests
        }
    }
}
