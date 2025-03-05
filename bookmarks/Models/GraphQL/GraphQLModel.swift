//
//  GraphQLModel.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//


struct GraphQLModelWithoutInput: Encodable {
    var operationString: String
    
    enum CodingKeys: String, CodingKey {
        case query
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(operationString, forKey: .query)
    }
}
