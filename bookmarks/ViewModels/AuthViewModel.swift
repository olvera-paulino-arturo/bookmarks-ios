//
//  AuthViewModel.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let authManager: AuthManager = AuthManager()
    private let countriesRepository = CountriesRepository()
    
    private let syncDataHelper = SyncDataHelper()
    
    
    @Published var email: FiledValidation = ""
    @Published var password: FiledValidation = ""
    
    @Published var isAuthFormValid = false
    @Published var isLoading: Bool = false
    @Published var hasMessage: Bool = false
    @Published var message: String = ""
    @Published var langages: [Language] = []
    
    @Published var selected: Language = Language(code: "", name: "", native: "")
    
    private var isAuthValidPublisher: AnyPublisher<Bool,Never> {
        Publishers.CombineLatest(email.$isValid, password.$isValid).map{
            $0 && $1
        }.eraseToAnyPublisher()
    }
    
    init() {
        self.isAuthValidPublisher
            .assign(to: \.isAuthFormValid, on: self)
            .store(in: &cancellables)
        
        self.$selected.sink {let _ = AppErrorHelper.containsError($0)}
        receiveValue: { language in
            LanguageHelper.setLanguage(language: language)
        }.store(in: &cancellables)
        
        self.countriesRepository.getLanguages()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink {let _ = AppErrorHelper.containsError($0)} receiveValue: { languages in
                self.langages = languages.languages
                if(!languages.languages.isEmpty) {
                    self.selected = languages.languages.first!
                }
                
        }
        .store(in: &cancellables)

    }
    
    
    func onCredentialAuth(splashViewModel: SplashViewModel) {
        isLoading = true
        authManager.withCredentials(email: email.value, password: password.value)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink {
                if AppErrorHelper.containsError($0) != nil {
                    print("Imposible Error")
                }
                
               
        } receiveValue: { result in
            switch result {
                
            case .badCredentials:
                self.message = NSLocalizedString("badCredentials", comment: "")
                self.hasMessage = true
                break
            case .userNotVerified:
                self.message = NSLocalizedString("userPendingVerification", comment: "")
                self.hasMessage = true
                break
            case .userLogged:
                Task {
                    InMemory.shared.email = self.email.value
                    await self.syncDataHelper.syncLocalData()
                }
                splashViewModel.moveTo(Routes.main)
            }
            
            self.isLoading = false
        }
        .store(in: &self.cancellables)
    }
    
    func onGoogleAuth(splashViewModel: SplashViewModel) {
        isLoading = true
        authManager.signInWithGoogle()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink {
                if AppErrorHelper.containsError($0) != nil {
                print("Imposible Error")
            }
                
            } receiveValue: { result in
                switch result {
                    
                case .badCredentials:
                    self.message = NSLocalizedString("badCredentials", comment: "")
                    self.hasMessage = true
                    break
                case .userNotVerified:
                    self.message = NSLocalizedString("userPendingVerification", comment: "")
                    self.hasMessage = true
                    break
                case .userLogged:
                    Task {
                        await self.syncDataHelper.syncLocalData()
                    }
                    splashViewModel.moveTo(Routes.main)
                }
                
                self.isLoading = false
            }
            .store(in: &self.cancellables)
    }
    
    
}
