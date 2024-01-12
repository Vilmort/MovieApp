//
//  KPArtistEntity.swift
//  KPNetwork
//
//  Created by Victor on 12.01.2024.
//

import Foundation

public struct KPArtistEntity: Decodable {
    
    public struct Movie: Decodable {
        public let id: Int
    }
    
    public struct Value: Decodable {
        public let value: String?
    }
    
    public let id: Int
    public let name: String?
    public let photo: String?
    public let enName: String?
    public let birthPlace: [Value]?
    public let profession: [Value]?
    public let age: Int?
    public let death: String?
    public let birthday: String?
    public let growth: Int?
    public let movies: [Movie]?
}
