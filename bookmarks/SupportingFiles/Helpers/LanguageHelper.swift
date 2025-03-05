//
//  LanguageHelper.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import Foundation

struct LanguageHelper {
    static private let key = "langugage"
    static func setLanguage(language: Language) {
        UserDefaults.standard.set(language.code, forKey: key)
    }
    
    static func readLanguage() -> String {
        guard let code = UserDefaults.standard.string(forKey: key) else {
            return "en"
        }
        return code
    }
    
    static func removeLanguage() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
