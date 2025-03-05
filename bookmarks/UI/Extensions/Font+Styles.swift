//
//  Font+Styles.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

extension Font {
    
    public static var bodySize: CGFloat { UIFont.preferredFont(forTextStyle: .callout).pointSize }

    
    public static func systemCustom(size: CGFloat = bodySize, weight: Font.Weight = .regular) -> Font {
        var font = "OpenSans-Regular"
        switch weight {
        case .bold: font = "OpenSans-Bold"
        case .heavy: font = "OpenSans-Bold"
        case .light: font = "OpenSans-Light"
        case .medium: font = "OpenSans-Regular"
        case .semibold: font = "OpenSans-SemiBold"
        case .thin: font = "OpenSans-Light"
        case .ultraLight: font = "OpenSans-Light"
        default: break
        }
        return Font.custom(font, size: size)
    }
}



