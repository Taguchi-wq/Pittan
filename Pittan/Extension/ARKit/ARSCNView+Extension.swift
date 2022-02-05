//
//  ARSCNView+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/20.
//

import ARKit

public extension ARSCNView {
    
    // MARK: - Properties
    /// sceneViewの中心
    var screenCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    
    // MARK: - Methods
    func getRaycastQuery(from point: CGPoint, for alignment: ARRaycastQuery.TargetAlignment = .any) -> ARRaycastQuery? {
        return raycastQuery(from: point, allowing: .estimatedPlane, alignment: alignment)
    }
    
    func castRay(for query: ARRaycastQuery) -> [ARRaycastResult] {
        return session.raycast(query)
    }
    
    func getHitObject(_ location: CGPoint) -> SCNNode? {
        return hitTest(location, options: nil).first?.node
    }
    
}
