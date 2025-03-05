//
//  Loader.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct Loader: View {
    @Binding var isShow: Bool
    @State var isRotating: Double = 0
   
    var body: some View {
        ConditionalRender(condition: isShow) {
            
            BackgroundStructure {
                LoaderContent(isRotating: $isRotating)
            }
        } fallback: {
            EmptyView()
        }
        
    }
}


#if DEBUG

#Preview {
    Loader(isShow: Binding<Bool>.constant(true))
}
#endif
