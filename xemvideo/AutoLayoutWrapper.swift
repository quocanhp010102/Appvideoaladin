//
//  AutoLayoutWrapper.swift
//  halodemoAladin
//
//  Created by quocanhppp on 11/07/2024.
//

import UIKit

@propertyWrapper
public struct AutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}

