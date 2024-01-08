//
//  UDService.swift
//  MovieApp
//
//  Created by Vanopr on 27.12.2023.
//

import Foundation

struct UDService {
    static let ud = UserDefaults.standard
    enum UDCases: String {
        case onboarding = "onboardingCompleted"
    }
    
    static func ifOnboardingCompleted() -> Bool {
        ud.bool(forKey: UDCases.onboarding.rawValue)
    }
    
    static func onboardingCompleted() {
        UserDefaults.standard.set(true, forKey: UDCases.onboarding.rawValue)
    }
}
