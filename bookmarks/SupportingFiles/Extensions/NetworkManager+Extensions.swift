//
//  NetworkManager+Extensions.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import Foundation
import Combine
import Alamofire
extension NetworkManager {
    
    internal static func handleResponse<T>(_ response: DataResponse<T, AFError>) throws ->  T {
        switch response.result {
            case .failure(let error):
            throw AppException(message: error.localizedDescription, messageType: .console)
            case .success:
            return try response.result.get()
        }
    }
    
    internal static func setHeader(urlRequest: URLRequest, requestType: HTTPMethod, tokenID: String?) -> URLRequest? {
        var request = urlRequest
        request.method = requestType
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let tokenID = tokenID {
            request.setValue(tokenID, forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
