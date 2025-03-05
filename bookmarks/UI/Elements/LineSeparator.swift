//
//  LineSeparator.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct LineSeparator: View {
    var body: some View {
        HStack {
            Rectangle().fill(.grey500).frame(height: 0.5)
            
            Text("or")
                .font(.systemCustom(size: 14, weight: .regular))
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Rectangle().fill(.grey500).frame(height: 0.5)
        }.padding(.horizontal, 10)
    }
}
