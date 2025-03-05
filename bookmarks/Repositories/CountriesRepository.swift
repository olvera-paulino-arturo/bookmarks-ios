//
//  CountriesRepository.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import Foundation
import Combine

class CountriesRepository {
    private let graphQLManager = GraphQLManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    func getLanguages() -> Future<Languages, AppException> {
        return Future { promise in
            guard let url = URL(string: "https://countries.trevorblades.com/graphql") else {
                promise(Result.failure(AppException(message: "Invalid URL")))
                return
            }
            
            let model = GraphQLModelWithoutInput(operationString: LanguageQuery.query)
            
            guard let request = GraphQLManager.prepareRequest(url: url, data: model.toData() ) else {
                promise(Result.failure(AppException(message: "Invalid Request")))
                return
            }
            
            
            self.graphQLManager.requestGL(request, returnType: Languages.self).sink { completionResult in
                 if let error = AppErrorHelper.containsError(completionResult){
                     promise(Result.failure(AppException(message: error.localizedDescription)))
                 }
             } receiveValue: { response in
                 promise(Result.success(response.data))
             }.store(in: &self.cancellables)
            
        }
    }
    
}

