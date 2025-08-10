//
//  InjectedPropertyWrapper.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation


@propertyWrapper
struct Injected<T> {
   private let keyPath: WritableKeyPath<InjectedValues, T>
   
   var wrappedValue: T {
       get { InjectedValues[keyPath] }
       set { InjectedValues[keyPath] = newValue }
   }
   
   init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
       self.keyPath = keyPath
   }
}
