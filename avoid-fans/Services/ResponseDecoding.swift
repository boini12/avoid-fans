//
//  ResponseDecoding.swift
//  avoid-fans
//
//  Created by Ines Bohr on 30.01.26.
//

import Foundation

protocol ResponseDecoding {
    func decodeJSONResponse<T: Decodable>(_ data: Data) throws -> T where T: Decodable
}

extension InjectedValues {
    var responseDecodeService : ResponseDecoding {
        get {
            Self[ResponseDecodeServiceKey.self]
        }
        set {
            Self[ResponseDecodeServiceKey.self] = newValue
        }
    }
}

private struct ResponseDecodeServiceKey: InjectionKey {
    static var currentValue: ResponseDecoding = ResponseDecodeService()
}

