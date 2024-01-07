//
//  HomeViewControllerModel.swift
//  MovieApp
//
//  Created by Vadim Zhelnov on 29.12.23.
//

import Foundation

enum HomeSection:Hashable,CaseIterable{
    case popularCategories
    case categories
    case mostPopular
    
//    var items:[ListItem]{
//        switch self{
//        case .popularCategories(let items),
//             .categories(let items),
//             .mostPopular(let items):
//            return items
//        }
//    }
    var title:String{
        switch self{
        case .popularCategories:
            return "Categories"
        case .categories:
            return "Genres"
        case .mostPopular:
            return "Most Popular"
        }
    }
    var button:String{
        switch self{
        case .popularCategories:
            return "See All"
        case .categories:
            return ""
        case .mostPopular:
            return "See All"
        }
    }
}

enum HomeItem:Hashable{
    case popularCategories(PopularCategoriesModel)
    case categories(CategoriesModel)
    case mostPopular(MostPopularFilmsModel)
}

struct PopularCategoriesModel:Hashable{
    var title:String
    var subTitle:String
    var image:String
    
    static let firstPopularCategory:Self = .init(title: "100 Great Films", subTitle: "50 films", image: "folder")
    static let secondPopularCategory:Self = .init(title: "200 Great Films", subTitle: "150 films", image: "no-results")
    static let thirdPopularCategory:Self = .init(title: "300 Great Films", subTitle: "100 films", image: "question")
}
struct CategoriesModel:Hashable{
    var title:String
    static let firstCategory:Self = .init(title: "All")
    static let secondCategory:Self = .init(title: "Comedy")
    static let thirdCategory:Self = .init(title: "Animation")
    static let fourthCategory:Self = .init(title: "Dokumentary")
}
struct MostPopularFilmsModel:Hashable{
        var title:String
        var subTitle:String
        var image:String
        var startImage:String
    
    static let firstPopulaFilm:Self = .init(title: "Spider Man", subTitle: "Action", image: "folder", startImage: "")
    static let secondPopulaFilm:Self = .init(title: "Live of Pie", subTitle: "Action", image: "no-results", startImage: "")
    static let thirdPopulaFilm:Self = .init(title: "Riverdal", subTitle: "Action", image: "question", startImage: "")
}
//struct HomeModel:Hashable{
//    static let shared = MockData()
//    var id = UUID()
//    var title:String
//    var subTitle:String
//    var image:String
//    var startImage:String
//    
//    init(title: String, subTitle: String, image: String,startImage:String) {
//        self.title = title
//        self.subTitle = subTitle
//        self.image = image
//        self.startImage = startImage
//    }
//    static func == (lhs: MockData, rhs: MockData) -> Bool {
//        lhs.id == rhs.id
//    }
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    private let popularCategories:Section = {
//        .popularCategories([.init(title: "100 Great Films", subTitle: "50 films", image: "folder", startImage: ""),
//                            .init(title: "200 Great Films", subTitle: "150 films", image: "no-results", startImage: ""),
//                            .init(title: "300 Great Films", subTitle: "100 films", image: "question", startImage: "")])
//    }()
//    private let categories:Section = {
//        .categories([.init(title: "All", subTitle: "", image: "", startImage: ""),
//                     .init(title: "Comedy", subTitle: "", image: "", startImage: ""),
//                     .init(title: "Animation", subTitle: "", image: "", startImage: ""),
//                     .init(title: "Documentary", subTitle: "", image: "", startImage: "")])
//}()
//    private let mostPopular:Section = {
//        .popularCategories([.init(title: "Spider Man", subTitle: "Action", image: "folder", startImage: ""),
//                            .init(title: "Live of Pie", subTitle: "Action", image: "no-results", startImage: ""),
//                            .init(title: "Riverdal", subTitle: "Action", image: "question", startImage: "")])
//    }()
//    var sectionData:[Section]{
//        [popularCategories,categories,mostPopular]
//    }
//  
//}
//
