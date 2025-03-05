//
//  MovieDetailsView.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct MovieDetailsView: View {
    var movie: Movie
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = MovieDetailsViewModel()
    
    var body: some View {
        VStack {
            AppBar(title: "moviesTitle", backAction: {
                self.presentationMode.wrappedValue.dismiss()
            })
            
            HStack(alignment: .center) {
                RemoteImage(url: "\(ServerConfiguration.imageURL)\(movie.posterPath)") {
                    Image(systemName: "film.circle")
                }
                .frame(width: 85, height: 150)
                .aspectRatio(contentMode: .fit)
                .padding(.leading, .padding6)
                VStack(alignment: .leading) {
                    HStack {
                        Text(movie.title)
                            .foregroundColor(.grey500)
                            .font(Font.systemCustom(size: 18, weight: .regular))
                           
                    }
                    .padding(.leading,.padding16)
                    .padding(.bottom, .padding6)
                    
                    
                    HStack {
                        Text(movie.overview)
                            .font(Font.systemCustom(size: 12, weight: .regular))
                            .foregroundColor(.grey600)
                            .padding(.leading,.padding16)
                            
                        Spacer()
                    }
                    .padding(.bottom, .padding16)
                }
            }.padding(.top, .padding12)
            
            HStack{
                Text("\(NSLocalizedString("releaseDate", comment: "releaseDate"))\(movie.releaseDate)")
                    .font(Font.systemCustom(size: 12, weight: .regular))
                    .foregroundColor(.grey600)
                    .padding(.vertical,.padding16)
                Spacer()
            }.padding(.horizontal,.padding20)
            
            Spacer()
            
            ConditionalRender(condition: viewModel.isFavorite) {
                Button {
                    viewModel.removeFromFavorites(movie: movie)
                } label: {
                    BaseButton(title: "removeFavorites",style: .outline)
                }
            } fallback: {
                Button {
                    viewModel.addToFavorites(movie: movie)
                } label: {
                    BaseButton(title: "addFavorites",style: .primary)
                }
            }.padding(.horizontal,.padding20)

            
        }.onAppear(perform: {
            viewModel.checkIsFavorite(movie: movie)
        })
        .navigationBarBackButtonHidden(true)
    }
}

