//
//  LanguageDropdown.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import SwiftUI

struct LanguageDropdown: View {
    var options: [Language]
    @Binding var selected: Language
    
    var body: some View {
        Menu(selected.name) {
            ForEach(options.indices, id: \.self) { index in
                Button(action: {
                    selected = options[index]
                }, label: {
                    HStack {
                        Text(options[index].name)
                            .foregroundStyle(Color.white)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                        
                    }
                })
            }
        }
        .padding(.all, 16)
        .foregroundStyle(Color.white)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.mainColor200))

    }
}
