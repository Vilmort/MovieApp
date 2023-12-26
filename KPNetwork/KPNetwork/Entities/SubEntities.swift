//
//  SubEntities.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public struct KPImage: Decodable {
    let url: String?
    let previewUrl: String?
}

public enum KPMovieType: String, Decodable {
    case movie
    case tvSeries = "tv-series"
    case anime
    case cartoon
    case animatedSeries = "animated-series"
}

public struct KPName: Decodable {
    let name: String?
    let language: String?
    let type: String?
}

public struct KPRating: Decodable {
    let kp: Double?
    let imdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let await: Double?
}

public struct KPVotes: Decodable {
    let kp: Double?
    let imdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
    let await: Double?
}


public struct KPAudience: Decodable {
    let count: Int
    let country: String
}

public struct KPBudget: Decodable {
    let value: Int?
    let currency: String?
}

public struct KPExternalId: Decodable {
    let kpHD, imdb: String?
}

public struct KPFact: Decodable {
    let value, type: String?
    let spoiler: Bool?
}

public struct KPFees: Decodable {
    let world, russia, usa: KPBudget?
}

public struct KPImagesInfo: Decodable {
    let postersCount, backdropsCount, framesCount: Int?
}

public struct KPLogo: Decodable {
    let url: String?
}

public struct KPNetwork: Decodable {
    let items: [KPNetworkItem]?
}

public struct KPNetworkItem: Decodable {
    let name: String?
    let logo: KPLogo?
}

public struct KPPerson: Decodable {
    let id: Int
    let photo: String?
    let name, enName: String?
    let description: String?
    let profession: String?
    let enProfession: String?
}

public struct KPPremiere: Decodable {
    let country, world, russia, digital: String?
    let cinema, bluray, dvd: String?
}

public struct KPReleaseYear: Decodable {
    let start, end: Int?
}

public struct KPReviewInfo: Codable {
    let count, positiveCount: Int?
    let percentage: String?
}

public struct KPSeasonsInfo: Codable {
    let number, episodesCount: Int?
}

public struct KPSequelsAndPrequel: Decodable {
    let id: Int
    let rating: KPRating?
    let year: Int?
    let name, enName, alternativeName, type: String?
    let poster: KPImage?
}

public struct KPVideos: Decodable {
    let trailers, teasers: [KPVideo]?
}

public struct KPVideo: Decodable {
    let url: String?
    let name, site, type: String?
    let size: Int?
}

public struct KPWatchability: Decodable {
    let items: [KPWatchabilityItem]?
}

public struct KPWatchabilityItem: Decodable {
    let name: String?
    let logo: KPLogo?
    let url: String?
}
