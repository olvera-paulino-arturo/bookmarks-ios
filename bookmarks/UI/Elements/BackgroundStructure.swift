//
//  BackgroundStructure.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct BackgroundStructure<Content: View>: View {
    let backgroundOpacity = 0.7
    var content: () -> Content
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black100.opacity(backgroundOpacity))
                .ignoresSafeArea()
                .transition(.opacity)
            
            self.content()
        }
    }
}
