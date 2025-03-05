//
//  FloatingAlert.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct FloatingAlert: View {
    @Binding var isShow: Bool
    var message: String
    @State var isDismiss: Bool = false
    @State private var padding: CGFloat = .padding12
    
    init(isShow: Binding<Bool>, message: String) {
        self._isShow = isShow
        self.message = message
    }
    
    var body: some View {
        
        ConditionalRender(condition: isShow) {
            ConditionalRender(condition: isDismiss) {
                EmptyView()
            } fallback: {
                ZStack {
                    RoundedRectangle(cornerRadius: .radius8)
                        .foregroundColor(Color.white.opacity(0.6))
                        .shadow(color: .mainColor100.opacity(0.8), radius: .radius8, x: 5, y: 6)
                    HStack {
                        HStack{
                            HStack {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.grey100)
                                    .padding(.vertical, padding)
                                Text("\(message)")
                                    .font(Font.systemCustom(size: 16, weight: .regular))
                                    .foregroundColor(.white)
                                    .padding(.vertical, padding)
                                Spacer()
                                Spacer()
                           
                            }
                            .padding(.horizontal, .padding12)
                        }
                        
                        .overlay(
                            RoundedRectangle(cornerRadius: .radius8)
                                .stroke(.mainColor100, lineWidth: 1)
                            
                        )
                        
                    }.background(.red500.opacity(0.2))
                        .cornerRadius(.radius8)
                }
                .fixedSize(horizontal: false, vertical: true)
                .onTapGesture {
                    withAnimation {
                        if self.isShow {
                            self.isShow.toggle()
                        }

                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
                        if self.isShow {
                            withAnimation {
                                self.isShow.toggle()
                            }
                        }
                    }
                }
                    
                
            }
        } fallback: {
            EmptyView()
        }

        
    }
}

#Preview {
    FloatingAlert(isShow: Binding<Bool>.constant(true), message: "Test Alert Message")
}


