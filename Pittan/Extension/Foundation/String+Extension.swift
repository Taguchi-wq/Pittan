//
//  String+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/10.
//

import Foundation

public extension String {
    
    /// Int型かどうか
    var isNumber: Bool {
        Int(self) != nil
    }
    
}
