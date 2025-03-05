//
//  MoviesView.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel = MoviesViewModel()
    
    var body: some View {
            VStack {
                AppBar(title: "moviesTitle")
                FloatingAlert(isShow: self.$viewModel.hasMessage, message: self.viewModel.message)
                    .padding(.vertical, .padding12)
                
                
                ConditionalRender(condition: !viewModel.movies.isEmpty) {
                    List {
                        ForEach(viewModel.movies.indices, id: \.self){ index in
                           MovieItem(
                                    title: viewModel.movies[index].title,
                                    description: viewModel.movies[index].overview,
                                    type: .bookmark, onAction: {
                                        viewModel.addToFavorites(index: index)
                                })
                            .navigation{
                                MovieDetailsView(movie: viewModel.movies[index])
                                    
                            }
                            .listRowBackground(Color.white.opacity(0.5))
                            .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        }
                    }
                    .refreshable {
                        viewModel.reloadMovies()
                    }
                    .listStyle(.plain)
                    .listRowSpacing(10)
                    .scrollContentBackground(.hidden)
                } fallback: {
                    ListLoader(isError: $viewModel.hasError) {
                        viewModel.reloadMovies()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    MoviesView()
}
