//
//  ConditionalRender.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//
import SwiftUI

struct ConditionalRender<SuccessContent : View, FallbackContent: View>: View {
    var condition: Bool
    var success: () -> SuccessContent
    var fallback: () -> FallbackContent
    
    var body: some View {
        VStack {
            if condition {
                self.success()
            } else {
                self.fallback()
            }
        }
    }
}
