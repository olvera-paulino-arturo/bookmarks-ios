//
//  Shimmer.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import SwiftUI

struct Shimmer: View {
    var color: Color = Color.grey300
    var cornerRadius: CGFloat = 2.0
    @State private var opacity: Double = Constants.minOpacity
    
    
    private struct Constants {
        static let duration: Double = 0.9
        static let minOpacity: Double = 0.25
        static let maxOpacity: Double = 1.0
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .opacity(opacity)
            .transition(.opacity)
            .animation(Animation.linear(duration: Constants.duration).repeatForever())
            .onAppear {
                self.opacity = Constants.maxOpacity
            }
    }
}


#if DEBUG
#Preview {
    VStack {
        Shimmer(color: Color.grey400)
        
            .frame(width: 100, height: 100)
    }
    .padding()
}
#endif
