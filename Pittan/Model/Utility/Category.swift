//
//  Category.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/10.
//

import Foundation

public enum Category: CaseIterable {
    case curtain
    case rug
    
    var name: String {
        switch self {
        case .curtain:
            return "カーテン"
        case .rug:
            return "ラグ"
        }
    }
}
