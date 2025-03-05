//
//  GraphQLManager.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//
import Foundation
import Combine
import Alamofire

class GraphQLManager {
    static let shared = GraphQLManager()
    
    internal static let validStatusCodeRange = 200..<300
    
    private static func handleResponse(output: URLSession.DataTaskPublisher.Output) throws ->  Data {
        guard let response = output.response as? HTTPURLResponse, validStatusCodeRange.contains(response.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
    static func prepareRequest(url: URL, data: Data?) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        return request
    }

    
    func requestGL<T: Codable>(_ request : URLRequest, returnType: T.Type ) -> AnyPublisher<GraphQLResult<T>,Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap(GraphQLManager.handleResponse)
            .decode(type: GraphQLResult<T>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

