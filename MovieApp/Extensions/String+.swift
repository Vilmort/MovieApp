//
//  String+.swift
//  MovieApp
//
//  Created by Vanopr on 05.01.2024.
//

import Foundation

//extension String {
//    var localized: String {
//        NSLocalizedString(self,
//                          comment: "\(self) could no be found in Localizable.strings")
//    }
//}

extension String {
    var localized: String {
        let lang = UDService.getLanguage()
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
