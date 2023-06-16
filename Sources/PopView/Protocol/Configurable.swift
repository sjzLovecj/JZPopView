//
//  Configurable.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/14.
//

import UIKit

public protocol Configurable { }
extension Configurable {
    func changing<T>(path: WritableKeyPath<Self, T>, to value: T) -> Self {
        var clone = self
        clone[keyPath: path] = value
        return clone
    }
}
