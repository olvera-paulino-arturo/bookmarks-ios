//
//  BaseButton.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct BaseButton: View {
    var title: LocalizedStringKey
    var image: ImageResource?
    var style: ButtonTheme = .primary
 
    var body: some View {
        HStack {
            HStack{
                ZStack{
                    ConditionalRender(
                        condition: image != nil) {
                            HStack{
                                Image(image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                Spacer()
                            }
                        } fallback: {
                            EmptyView()
                        }
                    Text(title)
                        .font(style.textStyle)
                        .foregroundColor(style.textColor)
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 48)

                }
                
                
            }.overlay(
                RoundedRectangle(cornerRadius: .radius8)
                    .stroke(style.borderColor, lineWidth: 1)
                
            )
        }.background(style.foregroundColor)
            .cornerRadius(.radius8)
            .frame(height: 48)
        
        
    }
}

#Preview {
    BaseButton(title: "accept", image: .google, style: .outline)
}
