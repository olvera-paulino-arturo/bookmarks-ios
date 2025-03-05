//
//  LoaderContent.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct LoaderContent: View {
    @Binding var isRotating: Double
    
    var body: some View {
        VStack{
            Image(.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .padding(.bottom, 24)
            
            Image(systemName: "arrow.triangle.2.circlepath")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.white.opacity(0.8))
                .frame(width: 50,height: 50)
                .rotationEffect(.degrees(isRotating))
                .onAppear {
                    withAnimation(.linear(duration: 1)
                        .speed(0.7).repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                }
        }
    }
}
