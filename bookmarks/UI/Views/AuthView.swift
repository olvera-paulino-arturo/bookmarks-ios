//
//  AuthView.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()
    @EnvironmentObject var splashViewModel : SplashViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Image(.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.bottom, 24)
                
                Title(title: "authTitle")
                
                FloatingAlert(isShow: self.$viewModel.hasMessage, message: self.viewModel.message)
                    .padding(.vertical, .padding12)
                
                Input(title: "emailField", text: $viewModel.email.value)
                
                Input(title: "passwordFiled", text: $viewModel.password.value, isPassword: true)
                
                Button {
                    self.viewModel.onCredentialAuth(splashViewModel: splashViewModel)
                } label: {
                    BaseButton(title: "authCredentials", style: self.viewModel.isAuthFormValid ? .primary : .primaryDisabled)
                }.disabled(!self.viewModel.isAuthFormValid)

                
                LineSeparator()
                
                Button {
                    self.viewModel.onGoogleAuth(splashViewModel: splashViewModel)
                } label: {
                    BaseButton(title: "googleButton", image: .google, style: .outline)
                }
                
            }.padding(15)
        }
        .taskLoader(with: $viewModel.isLoading)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AuthView()
}
