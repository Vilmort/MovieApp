//
//  KPMovieSearchEntity.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public struct KPMovieSearchEntity: Decodable {
    public let docs: [KPSearchMovie]
    public let total: Int
    public let limit: Int
    public let page: Int
    public let pages: Int
    
    public struct KPSearchMovie: Decodable {
        let id: Int
        let name: String?
        let alternativeName: String?
        let enName: String?
        let names: [KPName]
        let type: KPMovieType?
        let year: Int?
        let description: String?
        let shortDescription: String?
        let status: String?
        let rating: KPRating?
        let votes: KPVotes?
        let movieLength: Int?
        let ratingMpaa: String?
        let ageRating: Int?
        let poster: KPImage?
        let backdrop: KPImage?
        let genres: [KPName]?
        let countries: [KPName]?
        let top10: Int?
        let top250: Int?
    }
}
