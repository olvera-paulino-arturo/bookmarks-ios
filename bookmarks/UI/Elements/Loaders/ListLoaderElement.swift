//
//  ListLoaderElement.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import SwiftUI

struct ListLoaderElement: View {
    
    var body: some View {
        ZStack {
            Shimmer(color: .grey300, cornerRadius: .radius8)
                .frame(height: 48, alignment: .center)
                .padding(.horizontal, .padding16)
            HStack {
                RoundedRectangle(cornerRadius: .radius8)
                    .fill(.grey100)
                    .frame(width: 32, height: 32)
                    .padding(.leading, .padding6)
                    
                
                Spacer()
                
            }
            .padding(.horizontal, .padding16)
        }
    }
    
}
