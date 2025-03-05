//
//  TaskLoader.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI


struct TaskLoader: ViewModifier {
    @Binding var isShow: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ConditionalRender(condition: isShow) {
                Loader(isShow: $isShow)
            } fallback: {
                EmptyView()
            }
        }
    }
}

extension View {
    func taskLoader(with isShow: Binding<Bool>) -> some View {
        modifier(TaskLoader(isShow: isShow))
    }
}
