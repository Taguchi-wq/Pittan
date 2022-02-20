//
//  Category.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/10.
//

import Foundation

public enum Category: String, CaseIterable {
    case curtain = "カーテン"
    case rug = "ラグ"
    
    var index: Int {
        switch self {
        case .curtain:
            return 0
        case .rug:
            return 1
        }
    }
    
    var name: String {
        switch self {
        case .curtain:
            return "カーテン"
        case .rug:
            return "ラグ"
        }
    }
}
