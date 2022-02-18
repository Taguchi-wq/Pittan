//
//  ProductKind.swift
//  Pittan
//
//  Created by cmStudent on 2022/02/18.
//

import Foundation

public enum ProductKind: CaseIterable {
    case doubleCurtain, singleCurtain
    
    var imageName: String {
        switch self {
        case .doubleCurtain: return "double_curtain"
        case .singleCurtain: return "single_curtain"
        }
    }
    
    var name: String {
        switch self {
        case .doubleCurtain: return "両開き"
        case .singleCurtain: return "片開き"
        }
    }
    
    var sceneName: String {
        switch self {
        case .doubleCurtain: return "double_curtain.scn"
        case .singleCurtain: return "single_curtain.scn"
        }
    }
    
    var material: String {
        switch self {
        case .doubleCurtain: return "Mesh.001_11.001"
        case .singleCurtain: return "uploads_files_2420428_FA_Curtain_02_Default_OBJ"
        }
    }
}
