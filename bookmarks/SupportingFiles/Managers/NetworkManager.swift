//
//  NetworkManager.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import Alamofire
import Combine

class NetworkManager {
    
    lazy var session = Session(configuration: configuration)
    
    lazy var configuration: URLSessionConfiguration = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(ServerConfiguration.timeout)
        sessionConfig.timeoutIntervalForResource = TimeInterval(ServerConfiguration.timeout)
        return sessionConfig
    }()

    internal static let validStatusCodeRange = 200..<300
    
    
    static func prepareRequest(url: URL, requestType: HTTPMethod, tokenID: String? = nil, queryParameters: [URLQueryItem] = []) -> URLRequest? {
        var urlQuery = url
        if(!queryParameters.isEmpty) {
            urlQuery = url.appending(queryItems: queryParameters)
        }
        return setHeader(urlRequest: URLRequest(url: urlQuery), requestType: requestType, tokenID: tokenID)
    }
    
    
    func request<T: Codable>(_ request : URLRequestConvertible, returnType: T.Type) -> AnyPublisher<T, Error> {
        return session.request(request)
            .validate()
            .publishDecodable(type: T.self, decoder: JSONDecoder())
            .tryMap(NetworkManager.handleResponse)
            .eraseToAnyPublisher()
    }
}
