//
//  UrlErrorHandling.swift
//  avoid-fans
//
//  Created by Ines Bohr on 30.01.26.
//

import Foundation

protocol UrlErrorHandling {
    func handledecodingError(data: Data, error: Error) -> Void
}
