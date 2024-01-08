//
//  KPListSearchEntity.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public struct KPListSearchEntity: Decodable, Equatable, Hashable {
    
    public let docs: [KPList]
    
    public struct KPList: Decodable, Equatable, Hashable {
        public let category: String?
        public let name: String?
        public let slug: String?
        public let moviesCount: Int?
        public let cover: KPImage?
    }
}
