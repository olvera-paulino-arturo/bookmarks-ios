//
//  Input.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct Input: View {
    var title: LocalizedStringKey
    @Binding var text: String
    var isPassword: Bool = false
    
    var body: some View {
        VStack(alignment:.leading) {
            Text(title)
                .font(.systemCustom(size: 14, weight: .regular))
                .foregroundColor(.grey500)
                .padding(.top, 10)
                .padding(.bottom, 5)
            
            ConditionalRender(condition: isPassword) {
                SecureField(title, text: $text)
                    
                .textInputAutocapitalization(.never)
            } fallback: {
                TextField(title, text: $text)
                .textInputAutocapitalization(.never)
            }

            
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: .radius8)
                    .stroke(.grey300, lineWidth: 1)
                
            )
        }
        .padding(.bottom, 10)
    }
}
