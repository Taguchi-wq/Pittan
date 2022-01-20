//
//  SCNNode+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/20.
//

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
    
}
