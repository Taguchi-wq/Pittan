//
//  float4x4+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/20.
//

import ARKit

public extension float4x4 {
    
    var translation: SIMD3<Float> {
        get {
            let translation = columns.3
            return [translation.x, translation.y, translation.z]
        }
        set(newValue) {
            columns.3 = [newValue.x, newValue.y, newValue.z, columns.3.w]
        }
    }
    
    var orientation: simd_quatf {
        return simd_quaternion(self)
    }
    
}
