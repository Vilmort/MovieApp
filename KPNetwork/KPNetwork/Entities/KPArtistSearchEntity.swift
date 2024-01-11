//
//  KPArtistSearchEntity.swift
//  KPNetwork
//
//  Created by Victor on 12.01.2024.
//

import Foundation

public struct KPArtistSearchEntity: Decodable {
    public let docs: [KPArtist]
    public let total: Int
    public let limit: Int
    public let page: Int
    public let pages: Int
}
