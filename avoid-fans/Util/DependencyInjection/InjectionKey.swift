//
//  InjectionKey.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

public protocol InjectionKey {
    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value
    /// The default key for the dependency injection key.
    static var currentValue: Self.Value { get set}
}
