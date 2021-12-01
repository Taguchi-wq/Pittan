//
//  Reusable.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import Foundation

protocol Reusable {
    static var className: String { get }
}

extension Reusable {
    static var className: String {
        return String(describing: self)
    }
}

extension NSObject: Reusable {}
