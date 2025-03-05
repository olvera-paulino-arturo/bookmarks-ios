//
//  AppBar.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI


struct AppBar: View {
    
    var title: LocalizedStringKey
    var backAction:VoidCallback?
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ConditionalRender(condition: backAction != nil) {
                    Button {
                        backAction!()
                    } label: {
                        Image(systemName: "arrow.left").foregroundColor(.grey500)
                            .padding(.top,.padding16)
                    }
                    .padding(.bottom, .padding6)
                } fallback: {
                    Text("")
                        .padding(.bottom, .padding6)
                }
                Image(.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                
                Spacer()
                
            }
            
            
            Title(title: title)
                

        }.padding(.horizontal, 16)
    }
}

#Preview {
    AppBar(title: "moviesTitle",
           backAction: {
               print("")
           })
    
}
