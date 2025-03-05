//
//  ButtonTheme.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct ButtonTheme {
    var foregroundColor: Color
    var textColor: Color
    var borderColor: Color
    var textStyle: Font = Font.systemCustom(size: 18, weight: .semibold)
}


extension ButtonTheme {
    static var primaryDisabled: ButtonTheme {
        ButtonTheme(foregroundColor: .red200, textColor: .grey200, borderColor: .grey300)
    }
    
    static var primary: ButtonTheme {
        ButtonTheme(foregroundColor: .mainColor200, textColor: .white, borderColor: .mainColor200)
    }
    
    static var loginDisabled: ButtonTheme {
        ButtonTheme(foregroundColor: .grey200, textColor: .grey400, borderColor: .grey300)
    }
    
    static var login: ButtonTheme {
        ButtonTheme(foregroundColor: .white, textColor: .red200, borderColor: .white)
    }
    
    static var outline: ButtonTheme {
        ButtonTheme(foregroundColor: .clear, textColor: .grey400, borderColor: .mainColor200)
    }
}
