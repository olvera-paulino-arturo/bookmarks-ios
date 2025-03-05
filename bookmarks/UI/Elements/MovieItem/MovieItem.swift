//
//  MovieItem.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct MovieItem: View {
    var title: String
    var description: String
    var type: MovieActionType
    var hasTrimText: Bool = true
    var onAction: VoidCallback

    
    
    var body: some View {
        VStack {
            MovieItemContent(title: title, description: description, hasTrimText: hasTrimText)
        }
        .clipped()
        .overlay(
            RoundedRectangle(cornerRadius: .radius8)
                .stroke(Color.grey300, lineWidth: 1)
                .foregroundColor(Color.white.opacity(0.6))
                .shadow(color: .grey300.opacity(0.8), radius: .radius8, x: 5, y: 4)
                
        )
        .cornerRadius(8)
        .listRowSeparator(.hidden)
        .swipeActions(edge: .trailing, content: {
            MovieAction(type: type, onAction: onAction)
        })
        }
}


struct MovieItemContent : View {
    
    var title: String
    var description: String
    var hasTrimText: Bool
    
    var body: some View {
        HStack {
            HStack{
                VStack(alignment: .leading) {
                    HStack {
                        Text(title)
                            .foregroundColor(.grey500)
                            .font(Font.systemCustom(size: 18, weight: .regular))
                           
                    }
                    .padding(.leading,.padding16)
                    .padding(.bottom, .padding6)
                    .padding(.top, .padding12)
                    
                    HStack {
                        WrapText(description, hasTrimText: hasTrimText)
                            .font(Font.systemCustom(size: 12, weight: .regular))
                            .foregroundColor(.grey600)
                            .padding(.leading,.padding16)
                            
                        Spacer()
                    }
                    .padding(.bottom, .padding16)
                }
                Spacer()
                
            }
            
            
        }
        
    }
}


#Preview {
    MovieItem(title: "moviesTitle", description: "Demonstrates how to use SwiftUI", type: .delete) {
        print("")
    }
}
