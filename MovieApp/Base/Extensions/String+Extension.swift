//
//  String+Extension.swift
//  MovieApp
//
//  Created by Victor on 01.01.2024.
//

import Foundation

extension String {
    func stripHTML() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
}
