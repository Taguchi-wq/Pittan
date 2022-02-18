//
//  Tag.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/18.
//

import Foundation

public enum Tag: CaseIterable {
    case put
    case size
    
    
    var name: String {
        switch self {
        case .put: return "put"
        case .size: return "size"
        }
    }
    
    var japanese: String {
        switch self {
        case .put: return "設置"
        case .size: return "サイズ"
        }
    }
}
