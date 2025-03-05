//
//  Title.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct Title: View {
    
    var title:LocalizedStringKey
    
    var body: some View {
        
        HStack {
            Text(title)
                .font(Font.systemCustom(size: 26, weight: .semibold))
                .foregroundColor(.grey500)
                .padding(.trailing, .padding6)
            
            Spacer()
        }

    }
}

#Preview {
    Title(title: "moviesTitle")
    
}
