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
    var scaleWidth: Float {
        get { return scale.x }
        set { scale.x = newValue }
    }
    
    /// 縦幅
    var scaleHeight: Float {
        get { return scale.y }
        set { scale.y = newValue }
    }
    
    /// ミリメートル単位の横幅
    var millimeterWidth: Int {
        let (min, max) = boundingBox
        let width = (max.x - min.x)
        return Int(width * scaleWidth * 1000)
    }
    
    /// ミリメートル単位の縦幅
    var millimeterHeight: Int {
        let (min, max) = boundingBox
        let height = (max.y - min.y)
        return Int(height * scaleHeight * 1000)
    }
    
    
    // MARK: - Methods
    /// テクスチャを設定する
    /// - Parameter texture: テクスチャ
    /// - Parameter product: 製品
    func setTexture(_ texture: String) {
        let materials = geometry!.materials
        let material1 = "Default_OBJ"
        let material2 = "11"
        for material in materials where material.name == material1 || material.name == material2 {
            material.diffuse.contents = UIImage(named: texture)
            material.roughness.contents = 1
        }
    }
    
}
