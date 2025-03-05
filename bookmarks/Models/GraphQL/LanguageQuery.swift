//
//  LanguageQuery.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

struct LanguageQuery {
    
    static let query: String = """
                query Countries {
                    languages {
                        code
                        name
                        native
                    }
                }
            """
}
