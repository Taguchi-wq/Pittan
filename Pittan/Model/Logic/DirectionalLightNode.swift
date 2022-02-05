//
//  DirectionalLightNode.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/21.
//

import Foundation
import SceneKit

class DirectionalLightNode: SCNNode {
    
    // MARK: - Initialize
    override init() {
        super.init()
        
        light = SCNLight()
        light?.intensity = 1000
        light?.type = .directional
        position = SCNVector3(0, 0, 100)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
