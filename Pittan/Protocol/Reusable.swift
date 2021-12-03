//
//  Reusable.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import Foundation

public protocol Reusable {
    static var className: String { get }
}

public extension Reusable {
    static var className: String {
        return String(describing: self)
    }
}

extension NSObject: Reusable {}
