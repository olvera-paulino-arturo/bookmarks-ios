//
//  MovieRepository.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import Combine

class MovieRepository {
    private var cancellables = Set<AnyCancellable>()
    
    static let shared = MovieRepository()
    
    private let networkManager = NetworkManager()
    
    
    /*MARK: - GetMovies*/
    func  getMovies(movieRequest: MoviesRequest) ->  Future<MoviesResponse,AppException>  {
        return Future { promise in
            let endpoint: Endpoint = MovieEndpoints.getMovies
            guard let url = endpoint.definition else { return }
            guard let request = NetworkManager.prepareRequest(
                url: url, requestType: endpoint.method,
                tokenID: ServerConfiguration.apiKey,
                queryParameters: movieRequest.toQueryParams()) else {
                promise(Result.failure(AppException(message: "Preparacion Fallida")))
                return
            }

            
            self.networkManager.request(request, returnType: MoviesResponse.self)
                .sink { completionResult in
                    if let error = AppErrorHelper.containsError(completionResult){
                        if let appError = error as? AppException {
                            promise(Result.failure(appError))
                        } else {
                            promise(Result.failure(AppException(message: error.localizedDescription)))
                        }
                    }
                } receiveValue: { response in
                    promise(Result.success(response))
                    
                }
                .store(in: &self.cancellables)
            
        }
        
    }
}
