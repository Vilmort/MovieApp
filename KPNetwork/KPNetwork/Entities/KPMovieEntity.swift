//
//  KPMovieEntity.swift
//  KPNetwork
//
//  Created by Victor on 26.12.2023.
//

import Foundation

public struct KPMovieEntity: Decodable {
    public let id: Int
    public let externalId: KPExternalId?
    public let name, alternativeName, enName: String?
    public let names: [KPName]?
    public let type: KPMovieType?
    public let year: Int?
    public let description, shortDescription, slogan, status: String?
    public let rating: KPRating?
    public let votes: KPVotes?
    public let movieLength: Int?
    public let ratingMpaa: String?
    public let ageRating: Int?
    public let logo: KPLogo?
    public let poster, backdrop: KPImage?
    public let videos: KPVideos?
    public let genres, countries: [KPName]?
    public let persons: [KPPerson]?
    public let reviewInfo: KPReviewInfo?
    public let seasonsInfo: [KPSeasonsInfo]?
    public let budget: KPBudget?
    public let fees: KPFees?
    public let premiere: KPPremiere?
    public let similarMovies, sequelsAndPrequels: [KPSequelsAndPrequel]?
    public let watchability: KPWatchability?
    public let releaseYears: [KPReleaseYear]?
    public let top10, top250: Int?
    public let totalSeriesLength, seriesLength: Int?
    public let isSeries: Bool?
    public let audience: [KPAudience]?
    public let lists: [String]?
    public let networks: [KPNetwork]?
    public let facts: [KPFact]?
    public let imagesInfo: KPImagesInfo?
}
