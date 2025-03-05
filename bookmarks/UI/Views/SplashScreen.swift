//
//  SplashScreen.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct SplashScreen: View {
    @StateObject private var viewModel = SplashViewModel()
    
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack{
                Rectangle().fill(
                    LinearGradient(gradient: Gradient(colors: [.grey100, .red100, .red300]), startPoint: .top, endPoint: .bottom)
                ).ignoresSafeArea()
                
                LoaderContent(isRotating: $viewModel.isRotating)
            }.navigationDestination(for: Routes.self) {RouterManager.mainStack(route: $0, splashViewModel: viewModel)}
        }
    }
}



#Preview {
    SplashScreen()
}
