//
//  ListLoader.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import SwiftUI

struct ListLoader: View {
    
    @Binding var isError: Bool
    var onError: VoidCallback

    var body: some View {
        ZStack {
            List {
                ForEach(0..<5) { _ in
                    ListLoaderElement()
                    .listRowBackground(Color.white.opacity(0.5))
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        
                }
            }
            .refreshable {
                if(isError) {
                    onError()
                }
            }
            .listStyle(.plain)
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
            
            ConditionalRender(condition: isError) {
                VStack {
                    Button {
                        onError()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.red400.opacity(0.8))
                            .frame(width: 62,height: 62)
                    }
                    .padding(.top, .padding16)
                    
                    Spacer()
                }
            } fallback: {
                EmptyView()
            }
        }
    }
}
