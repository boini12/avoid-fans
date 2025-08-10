//
//  InjectedValues.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

struct InjectedValues {
    private static var current = InjectedValues()
    
    static subscript <K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    static subscript <T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

