//
//  SCNNode+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/20.
//

import UIKit
import SceneKit

public extension SCNNode {
    
    // MARK: - Properties
    /// 横幅
    var width: Float {
        get { return scale.z }
        set { scale.z = newValue }
    }
    
    /// 縦幅
    var height: Float {
        get { return scale.y }
        set { scale.y = newValue }
    }
    
    
    // MARK: - Methods
    /// テクスチャを設定する
    /// - Parameter texture: テクスチャ
    func setTexture(_ texture: String) {
        let materials = geometry!.materials
        for material in materials where material.name == "Default_OBJ" {
            material.diffuse.contents = UIImage(named: texture)
            material.roughness.contents = 1
        }
    }
    
}
