//
//  View+Navigation.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

extension View {
    func navigation <Destination: View>(_ destination: @escaping () -> Destination) -> some View {
        modifier(NavigationLinkModifier(destination: destination))
    }
}

fileprivate struct NavigationLinkModifier<Destination: View>: ViewModifier {
    var destination: () -> Destination
    
    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(destination: self.destination) { EmptyView() }.opacity(0)
            )
    }
}
