//
//  MainView.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import SwiftUI

enum MainTabs: Hashable {
    case releases
    case bookmarks
    case loggout
}

struct MainView: View {
    @StateObject var viewModel = MainViewModel.shared
    @EnvironmentObject var splashViewModel : SplashViewModel

    var body: some View {
        TabView(selection: $viewModel.tabSelection) {
            MoviesView()
                .tabItem {
                    Label("releasesTitle", systemImage: "popcorn.circle")
                }
                .tag(MainTabs.releases)

            BookmarksView()
                .tabItem {
                    Label("bookmarksTitle", systemImage: "star.circle")
                }
                .tag(MainTabs.bookmarks)
            
            Rectangle()
                .tabItem {
                    Label("loggoutTitle", systemImage: "rectangle.portrait.and.arrow.right")
                }
                .tag(MainTabs.loggout)
        }
        .onChange(of: viewModel.tabSelection, perform: { newValue in
            if(newValue == .loggout){
                viewModel.tabSelection = .releases
                viewModel.loggout()
                splashViewModel.moveTo(Routes.auth)
                
            }
        })
        .accentColor(.mainColor200)
        .navigationBarBackButtonHidden(true)
        
    }
}
