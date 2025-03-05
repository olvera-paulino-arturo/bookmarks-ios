//
//  DeleteAction.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI


struct MovieAction: View {
    var type: MovieActionType
    var onAction: VoidCallback
    
    var body: some View {
        Button {
            onAction()
        } label: {
            Image(systemName: type == MovieActionType.delete ? "trash" : "star.fill")
                .foregroundColor(.white)
        }
        .frame(width: 60, height: 50, alignment: .center)
        .tint(type == MovieActionType.delete ? .red : .yellow)
    }
}
