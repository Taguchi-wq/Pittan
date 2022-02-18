//
//  PatternKind.swift
//  Pittan
//
//  Created by cmStudent on 2022/02/18.
//

import Foundation

public enum PatternKind: CaseIterable {
    case beige, blue, brown, gray, navy, rose, turquoiseBlue, yellowgreen
    
    var imageName: String {
        switch self {
        case .beige: return "beige"
        case .blue: return "blue"
        case .brown: return "brown"
        case .gray: return "gray"
        case .navy: return "navy"
        case .rose: return "rose"
        case .turquoiseBlue: return "turquoise_blue"
        case .yellowgreen: return "yellowgreen"
        }
    }
    
    var name: String {
        switch self {
        case .beige: return "ベージュ"
        case .blue: return "ブルー"
        case .brown: return "ブラウン"
        case .gray: return "グレー"
        case .navy: return "ネイビー"
        case .rose: return "ローズ"
        case .turquoiseBlue: return "ターコイズブルー"
        case .yellowgreen: return "イエローグリーン"
        }
    }
}
