//
//  UIApplication+Extensions.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap{$0 as? UIWindowScene}
            .filter{ $0.activationState == .foregroundActive}
            .first?.windows
            .first(where: \.isKeyWindow)
    }
}
