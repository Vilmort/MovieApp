//
//  UDService.swift
//  MovieApp
//
//  Created by Vanopr on 27.12.2023.
//

import Foundation

enum AppLanguage: String {
    case english = "en"
    case russian = "ru"
}


struct UDService {
    static let ud = UserDefaults.standard
    enum UDCases: String {
        case onboarding = "onboardingCompleted"
        case selectedLanguageKey = "SelectedLanguage"
    }
    
    static func ifOnboardingCompleted() -> Bool {
        ud.bool(forKey: UDCases.onboarding.rawValue)
    }
    
    static func onboardingCompleted() {
        ud.set(true, forKey: UDCases.onboarding.rawValue)
    }
    
    static func switchLanguage(to language: AppLanguage) {
        ud.set(language.rawValue, forKey: UDCases.selectedLanguageKey.rawValue)
    }
    
    static func getLanguage() -> String {
        ud.string(forKey: UDCases.selectedLanguageKey.rawValue) ?? AppLanguage.english.rawValue
    }
    
}
