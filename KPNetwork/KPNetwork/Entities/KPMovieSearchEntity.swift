//
//  KPMovieSearchEntity.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public struct KPMovieSearchEntity: Decodable, Equatable, Hashable {
    public let docs: [KPSearchMovie]
    public let total: Int
    public let limit: Int
    public let page: Int
    public let pages: Int
    
    public struct KPSearchMovie: Decodable, Equatable, Hashable{
        public let id: Int
        public let name: String?
        public let alternativeName: String?
        public let enName: String?
        public let names: [KPName]
        public let type: KPMovieType?
        public let year: Int?
        public let description: String?
        public let shortDescription: String?
        public let status: String?
        public let rating: KPRating?
        public let votes: KPVotes?
        public let movieLength: Int?
        public let ratingMpaa: String?
        public let ageRating: Int?
        public  let poster: KPImage?
        public let backdrop: KPImage?
        public let genres: [KPName]?
        public let countries: [KPName]?
        public let top10: Int?
        public let top250: Int?
    }
}
