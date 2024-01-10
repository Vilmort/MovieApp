//
//  SubEntities.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public struct KPImage: Decodable, Equatable, Hashable {
    public let url: String?
    public let previewUrl: String?
    public let type: String?
}

public enum KPMovieType: String, Decodable, Equatable, Hashable {
    case movie
    case tvSeries = "tv-series"
    case anime
    case cartoon
    case animatedSeries = "animated-series"
}

public struct KPName: Decodable, Equatable, Hashable {
    public let name: String?
    public let language: String?
    public let type: String?
}

public struct KPRating: Decodable, Equatable, Hashable {
    public let kp: Double?
    public let imdb: Double?
    public let filmCritics: Double?
    public let russianFilmCritics: Double?
    public let await: Double?
}

public struct KPVotes: Decodable , Equatable, Hashable{
    public let kp: Double?
    public let imdb: Double?
    public let filmCritics: Double?
    public let russianFilmCritics: Double?
    public let await: Double?
}


public struct KPAudience: Decodable {
    public let count: Int
    public let country: String
}

public struct KPBudget: Decodable {
    public let value: Int?
    public let currency: String?
}

public struct KPExternalId: Decodable {
    public let kpHD, imdb: String?
}

public struct KPFact: Decodable {
    public let value, type: String?
    public let spoiler: Bool?
}

public struct KPFees: Decodable {
    public let world, russia, usa: KPBudget?
}

public struct KPImagesInfo: Decodable {
    public let postersCount, backdropsCount, framesCount: Int?
}

public struct KPLogo: Decodable {
    public let url: String?
}

public struct KPNetwork: Decodable {
    public let items: [KPNetworkItem]?
}

public struct KPNetworkItem: Decodable {
    public let name: String?
    public let logo: KPLogo?
}

public struct KPPerson: Decodable {
    public let id: Int
    public let photo: String?
    public let name, enName: String?
    public let description: String?
    public let profession: String?
    public let enProfession: String?
}

public struct KPPremiere: Decodable {
    public let country, world, russia, digital: String?
    public let cinema, bluray, dvd: String?
}

public struct KPReleaseYear: Decodable {
    public let start, end: Int?
}

public struct KPReviewInfo: Codable {
    public let count, positiveCount: Int?
    public let percentage: String?
}

public struct KPSeasonsInfo: Codable {
    public let number, episodesCount: Int?
}

public struct KPSequelsAndPrequel: Decodable {
    public let id: Int
    public let rating: KPRating?
    public let year: Int?
    public let name, enName, alternativeName, type: String?
    public let poster: KPImage?
}

public struct KPVideos: Decodable {
    public let trailers, teasers: [KPVideo]?
}

public struct KPVideo: Decodable {
    public let url: String?
    public let name, site, type: String?
    public let size: Int?
}

public struct KPWatchability: Decodable {
    public let items: [KPWatchabilityItem]?
}

public struct KPWatchabilityItem: Decodable {
    public let name: String?
    public let logo: KPLogo?
    public let url: String?
}
