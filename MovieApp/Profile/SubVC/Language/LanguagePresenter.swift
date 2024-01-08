//
//  File.swift
//  MovieApp
//
//  Created by Vanopr on 04.01.2024.
//

import Foundation

struct Language {
    let language: String
    var isSelected: Bool
    let id: AppLanguage
   
}

// MARK: - LanguagePresenterProtocol
protocol LanguagePresenterProtocol {
    init(view: LanguageVCProtocol)
    var languages:  [Language] { get }
    func whatLanguageSelected()
    func selectALanguage(index: Int)
}

// MARK: - LanguagePresenter
final class LanguagePresenter: LanguagePresenterProtocol {
    
    private unowned var view: LanguageVCProtocol
    
    var languages:  [Language] = [
        Language(language: "English", isSelected: false, id: .english),
        Language(language: "Русский", isSelected: false, id: .russian)
    ]
    
    init(view: LanguageVCProtocol) {
        self.view = view
    }
    
    func whatLanguageSelected() {
        for i in 0...languages.count - 1 {
            if UDService.getLanguage() == languages[i].id.rawValue {
                languages[i].isSelected = true
            }
        }
    }
    
    func selectALanguage(index: Int) {
        languages.indices.forEach { languages[$0].isSelected = false }
        languages[index].isSelected = true
        UDService.switchLanguage(to: languages[index].id )
    }
    
}
