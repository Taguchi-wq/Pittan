//
//  AppImage.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/01.
//

import Foundation

public enum AppImage: CaseIterable {
    case centralWoman
    
    var name: String {
        switch self {
        case .centralWoman:
            return "central_woman"
        }
    }
}
