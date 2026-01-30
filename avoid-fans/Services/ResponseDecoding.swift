//
//  ResponseDecoding.swift
//  avoid-fans
//
//  Created by Ines Bohr on 30.01.26.
//

import Foundation

protocol ResponseDecoding {
    func decodeJSONResponse<T: Decodable>(_ data: Data) throws -> T
}
