//
//  ResponseDecodeService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 30.01.26.
//

import Foundation

class ResponseDecodeService : ResponseDecoding {
    private let decoder: JSONDecoder = JSONDecoder()
    
    init(){
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func decodeJSONResponse<T: Decodable>(_ data: Data) throws -> T where T : Decodable {
        return try decoder.decode(T.self, from: data)
    }
    
}
